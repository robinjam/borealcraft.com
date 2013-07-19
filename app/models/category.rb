class Category < ActiveRecord::Base
  attr_accessible :title

  has_many :forums, dependent: :destroy

  validates :title, presence: true
end
