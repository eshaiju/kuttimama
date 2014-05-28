class Post < ActiveRecord::Base
  belongs_to :movie
  belongs_to :category

  has_many :posts_tags
  has_many :tags , :through => :posts_tags
  
  has_attached_file :image ,
		:processors => [:watermark],  										
	  	:styles => { :medium => "300x170>", :thumb => "100x100>" , :large => "600x250",
	  	:medium => {
        :geometry => '300x170>',
        :watermark_path => "#{Rails.root}/public/images/watermark.jpg",
        :position => 'NorthEast'
   							 },
   			:original => {
        :geometry => '750>',
        :watermark_path => "#{Rails.root}/public/images/watermark.jpg",
        :position => 'NorthEast'
   							 },
   			:thumb => {
        :geometry => '100x100>',
        :watermark_path => "#{Rails.root}/public/images/watermark.jpg",
        :position => 'NorthEast'
   							 },
   			:large => {
        :geometry => '600x250>',
        :watermark_path => "#{Rails.root}/public/images/watermark.jpg",
        :position => 'NorthEast'
   							 }
	  	},
	  :default_url => ActionController::Base.helpers.asset_path("user_default.png", type: :image)

  
end
