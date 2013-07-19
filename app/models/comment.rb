class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  attr_accessible :content

  validates :content, presence: true, length: { maximum: 10000 }
end
