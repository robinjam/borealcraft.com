class Forum < ActiveRecord::Base
  attr_accessible :title, :description
  
  belongs_to :category
  has_many :topics, dependent: :destroy
  has_many :comments, through: :topics

  validates_presence_of :title, :description
end
