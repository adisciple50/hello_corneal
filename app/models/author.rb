class Author < ActiveRecord::Base
  has_many :comments
  has_many :posts
  has_one :facebook
  has_one :twitter
  has_one :profile
end
