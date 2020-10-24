class Post < ActiveRecord::Base
  has_many :comment
  has_one :author
end
