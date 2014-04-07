module Trim
  class ContactSubject < ActiveRecord::Base

    has_many :contact_messages, :class_name => 'Trim::ContactMessage', :inverse_of => :contact_subjects

    attr_accessible :name, :email, :as => :admin

    validates :name, :presence => true

    # Email validation a-la: http://lindsaar.net/2010/1/31/validates_rails_3_awesome_is_true
    validates_presence_of :email, :message => "Email address can't be blank."
    validates_format_of :email, :with => /\A\S+@\S+\.{1}\S+\z/, :if => :email?

    #
    # Rails Admin Config
    #
    rails_admin do
      navigation_label 'Messages'
      label 'Subject'

      edit do 
        fields :name, :email
      end

      show do
        fields :name, :email, :updated_at, :created_at
      end

      list do
        fields :name, :email, :created_at
      end
    end

  end
end
