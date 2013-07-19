class Headline < ActiveRecord::Base
  attr_accessible :title, :content

  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, :content, presence: true
end
