module Trim
  class ContactMessage < ActiveRecord::Base

    attr_accessible :name, :message, :contact_subject_id, :phone, :email, 
                    :user_agent, :user_ip, :as => :admin

    belongs_to :contact_subject, :class_name => 'Trim::ContactSubject', :inverse_of => :contact_messages

    after_create :handle_contact_message

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
    
    def handle_contact_message
      Trim::ContactMailer.confirm_email(self).deliver
      Trim::ContactMailer.contact_email(self).deliver unless Trim.use_akismet && self.is_spam
    end


    if Trim.use_akismet

      include Rakismet::Model

      rakismet_attrs  :author => proc { self.name },
                      :author_email => proc { self.email },
                      :content => proc { self.message },
                      :user_ip => proc { self.user_ip },
                      :user_agent => proc { self.user_agent }

      scope :marked_as_spam, where(:is_spam => true)
      scope :not_spam, where(:is_spam => false)

      before_create :send_to_akismet

      def send_to_akismet
        self.is_spam = self.spam?
        
        # Should still create the object regardless of if it's spam or not
        true
      end

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
        fields :name, :email, :phone, :contact_subject, :created_at, :message
      end

      list do
        fields :name, :email, :contact_subject, :created_at
      end
    end

  end
end
