class Post < ActiveRecord::Base
  belongs_to :movie
  belongs_to :category
  belongs_to :tag
  has_attached_file :image, 
  								#	:storage => :dropbox,
  									:processors => [:watermark],
    								:dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    								#:path => "/:class/:attachment/:id_partition/:style/:filename",
									  :styles => { :medium => "300x170>", :thumb => "100x100>" , :small => "50x50",
									  	:medium => {
	                      :geometry => '300x170>',
	                      :watermark_path => "#{Rails.root}/public/images/watermark.png",
	                      :position => 'West'
                   							 },
                   			:original => {
	                      :geometry => '750>',
	                      :watermark_path => "#{Rails.root}/public/images/watermark.png",
	                      :position => 'West'
                   							 },
                   			:thumb => {
	                      :geometry => '100x100>',
	                      :watermark_path => "#{Rails.root}/public/images/watermark.png",
	                      :position => 'West'
                   							 },
                   			:small => {
	                      :geometry => '50x50>',
	                      :watermark_path => "#{Rails.root}/public/images/watermark.png",
	                      :position => 'West'
                   							 }

									  	},
									  :default_url => ActionController::Base.helpers.asset_path("user_default.png", type: :image)

	searchable do
    text :title
    integer :category_id    
  end
  
end
