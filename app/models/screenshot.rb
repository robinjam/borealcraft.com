class Screenshot < ActiveRecord::Base
  attr_accessible :title, :description, :image
  
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_attached_file :image, styles: { thumb: ["220x220>", :png], medium: ["960x>", :png] }, whiny: false

  validates_presence_of :title

  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: /^image\/.+$/, message: 'is not valid'
  validates_attachment_size :image, less_than: 10.megabytes, message: 'must be less than 10 megabytes'
end
