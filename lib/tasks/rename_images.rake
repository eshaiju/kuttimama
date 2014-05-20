namespace :db  do
  desc "Dummy Task"
  task :rename_images => :environment do
  	 p "inside task"
	  Post.all.each do |post|
	  	p post
	  	extension = File.extname(post.image_file_name).downcase
	    p new_file_name = "kuttimama-#{SecureRandom.hex(11)}#{extension}"
			(post.image.styles.keys).each do |style|
			  p path = post.image.path(style)
			  FileUtils.move(path, File.join(File.dirname(path), new_file_name))
			end
		p post.image_file_name = new_file_name
		p post.save
   end 
  end
end
