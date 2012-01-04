class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  attr_accessible :content

  validates_presence_of :content
  validates_length_of :content, maximum: 10000
end
