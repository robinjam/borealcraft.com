class Screenshot < ActiveRecord::Base
  attr_accessible :title, :description, :image
  
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_attached_file :image, {
  	styles: {
  		thumb: ["220x220>", :png],
  		medium: ["960x>", :png]
    }
  }

  validates :title, presence: true
  validates :image,
    attachment_presence: true,
    attachment_content_type: { content_type: /^image\/.+$/, message: 'is not valid' },
    attachment_size: { less_than: 10.megabytes, message: 'must be less than 10 megabytes' }
end
