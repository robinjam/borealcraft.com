class Topic < ActiveRecord::Base
  attr_accessible :title
  
  belongs_to :forum
  has_many :comments, as: :commentable, dependent: :destroy

  validates_presence_of :title
end
