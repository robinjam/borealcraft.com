class Screenshot < ActiveRecord::Base
  attr_accessible :title, :description, :image
  
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  STORAGE_OPTIONS = Rails.env.production? ? {
      path: ':attachment/:id/:style',
      storage: :s3,
      s3_credentials: {
        bucket: ENV['S3_BUCKET'],
        access_key_id: ENV['S3_ACCESS_KEY_ID'],
        secret_access_key: ENV['S3_SECRET_ACCESS_KEY']
      }
    } : {}

  has_attached_file :image, {
  	styles: {
  		thumb: ["220x220>", :png],
  		medium: ["960x>", :png] },
  	whiny: false
  }.merge(STORAGE_OPTIONS)

  validates_presence_of :title

  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: /^image\/.+$/, message: 'is not valid'
  validates_attachment_size :image, less_than: 10.megabytes, message: 'must be less than 10 megabytes'
end
