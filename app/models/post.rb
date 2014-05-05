class Post < ActiveRecord::Base
  belongs_to :movie
  belongs_to :category
  belongs_to :tag
end
