# Assuming you had a model like this
#
# class Post
#   has_attached_file :image, :path => ":rails_root/public/system/:attachment/:id/:style/:filename"
# end

namespace :paperclip do
  desc "Recreate attachments and save them to new destination"
  task :reprocess_images => :environment do

    Post.find_each do |post|

      unless post.image_file_name.blank?
        filename = Rails.root.join('public', 'system','posts', 'images','000','000', post.id.to_s.rjust(3, '0'), 'original', post.image_file_name)

         if File.exists? filename
          puts "Re-saving image attachment #{post.id} - #{filename}"
          image = File.new filename
          post.image = image
          post.save
          # if there are multiple styles, you want to recreate them :
          post.image.reprocess! 
          image.close
         end
      end
    end
  end
end