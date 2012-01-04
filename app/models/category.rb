class Category < ActiveRecord::Base
  attr_accessible :title

  has_many :forums, dependent: :destroy

  validates_presence_of :title
end
