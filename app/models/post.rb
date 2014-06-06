class Post < ActiveRecord::Base
  FIELDS_RENDERED = [:id, :title]
  METHODS_RENDERED = [:image_large_url, :image_medium_url]

  belongs_to :movie
  belongs_to :category
  attr_accessor :tags_as_text
  has_many :posts_tags
  has_many :tags , :through => :posts_tags
  
  has_attached_file :image ,
		:processors => [:watermark],  										
	  	:styles => { :medium => "300x170>", :thumb => "100x100>" , :large => "600x400",
	  	:medium => {
        :geometry => '300x170>',
        :watermark_path => "#{Rails.root}/public/images/watermark.jpg",
        :position => 'NorthEast'
   							 },
   			:large => {
        :geometry => '600x400>',
        :watermark_path => "#{Rails.root}/public/images/watermark.jpg",
        :position => 'NorthEast'
   							 }
	  	},
	  :default_url => ActionController::Base.helpers.asset_path("user_default.png", type: :image)

  def image_large_url
    image.url(:large)
  end

  def image_medium_url
    image.url(:medium)
  end

  def as_json(options={})
    super(:methods => Post::METHODS_RENDERED,
          :only => Post::FIELDS_RENDERED)
  end

end
