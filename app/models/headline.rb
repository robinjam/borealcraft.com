class Headline < ActiveRecord::Base
  attr_accessible :title, :content

  has_many :comments, as: :commentable, dependent: :destroy

  validates_presence_of :title, :content
end
