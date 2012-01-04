class Topic < ActiveRecord::Base
  attr_accessible :title
  
  belongs_to :forum
  has_many :comments, as: :commentable, dependent: :destroy

  accepts_nested_attributes_for :comments

  validates_presence_of :title

  def user
    comments.first.user
  end

  def replies
    comments.count - 1
  end
end
