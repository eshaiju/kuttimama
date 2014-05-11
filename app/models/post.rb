class Post < ActiveRecord::Base
  belongs_to :movie
  belongs_to :category
  belongs_to :tag
  has_attached_file :image, :styles => { :medium => "300x170>", :thumb => "100x100>" , :small => "38x38"},:default_url => ActionController::Base.helpers.asset_path("user_default.png", type: :image)
  
end
