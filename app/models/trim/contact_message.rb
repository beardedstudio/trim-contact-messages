module Trim
  class ContactMessage < ActiveRecord::Base

    attr_accessible :name, :message, :contact_subject_id, :phone, :email, 
                    :user_agent, :user_ip, :attachments, :attachments_attributes

    include Rakismet::Model
    
    rakismet_attrs  :author => proc { self.name },
                    :author_email => proc { self.email },
                    :content => proc { self.message },
                    :user_ip => proc { self.user_ip },
                    :user_agent => proc { self.user_agent }

    scope :marked_as_spam, where(:is_spam => true)
    scope :not_spam, where(:is_spam => false)
    
    belongs_to :contact_subject, :class_name => 'Trim::ContactSubject', :inverse_of => :contact_messages

    has_many :attachments, :class_name => 'Trim::ContactAttachment', :inverse_of => :contact_message, :dependent => :destroy
    accepts_nested_attributes_for :attachments, :allow_destroy => true

    before_create :send_to_akismet
    after_create :handle_contact_message
    after_create :handle_message_attachments

    # Email validation a-la: http://lindsaar.net/2010/1/31/validates_rails_3_awesome_is_true
    validates_presence_of :email, :message => "Email address can't be blank."
    validates_presence_of :message, :message => "Message can't be blank."
    validates_format_of :email, :with => /\A\S+@\S+\.{1}\S+\z/, :if => :email?

    validates :contact_subject_id,  :presence => { :message => "Subject must be selected." },
                                    :numericality => { :greater_than => 0 }

    validates_length_of :email, :name, :phone, :maximum => 255



    def subject
      self.contact_subject.name
    end

    def send_to_akismet
      self.is_spam = self.spam?
      
      # Should still create the object regardless of if it's spam or not
      return true
    end
    
    def handle_contact_message
      Trim::ContactMailer.confirm_email(self).deliver
      Trim::ContactMailer.contact_email(self).deliver unless self.is_spam
    end

    def handle_message_attachments
      # destroy attachments and their associated files
      # if the message is flagged as spammy
      self.attachments.destroy_all if self.is_spam
    end


    #
    # Rails Admin Config
    #
    rails_admin do
      navigation_label 'Messages'
      label "Contact Messages"

      configure :contact_subject do 
        label "Subject" 
      end

      show do
        fields :message, :name, :email, :phone, :contact_subject
        field :created_at
        field :attachments do
          label "Attachments"
          pretty_value do 
            value.map do |attachment|
              title = attachment.attachment_file_name
              title << " (#{attachment.attachment_content_type}, #{attachment.attachment_file_size} bytes)"
              bindings[:view].link_to(title, attachment.attachment.url)
            end.join.html_safe
          end
        end
      end

      list do
        fields :name, :email, :contact_subject, :created_at
      end
    end

  end
end
