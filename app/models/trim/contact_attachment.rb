module Trim
  class ContactAttachment < ActiveRecord::Base
    
    attr_accessible :contact_message_id, :attachment

    belongs_to :contact_message, :inverse_of => :attachments

    has_attached_file :attachment,
      :storage => :s3,
      :s3_credentials => {
        :bucket => ENV['AWS_BUCKET'],
        :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']},
      :s3_headers => { 'Cache-Control' => 'max-age=315576000', 'Expires' => 1.years.from_now.httpdate },
      :path => '/contact_attachments/:id/:filename'

    validates_attachment_size :attachment, :less_than => 5.megabytes
    validates_attachment_content_type :attachment, :content_type=>['image/jpg', 'image/jpeg', 'image/png', 'image/gif', 'application/pdf']

    def title
      "Attachment ##{self.id}"
    end

    #
    # Rails Admin Config
    #
    rails_admin do
      visible false
      nested do 
        field :attachment
      end
    end

  end
end
