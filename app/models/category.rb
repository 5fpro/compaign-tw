class Category < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :petitions
  
  validates_uniqueness_of :name
  validates_presence_of :name
end
