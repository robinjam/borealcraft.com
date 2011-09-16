class Screenshot < ActiveRecord::Base
  attr_accessible :title, :description
  
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_attached_file :image, styles: { thumb: ["100x100>", :png] }

  validates_presence_of :title

  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: /^image\/.+$/
  validates_attachment_size :image, less_than: 10.megabytes
end
