class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  attr_accessible :content

  validates_length_of :content, minimum: 15, maximum: 1000
end
