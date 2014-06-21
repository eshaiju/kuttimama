namespace :paperclip do
  desc "Recreate attachments and save them to new destination"
  task :rename_images => :environment do
  	 Post.find_each do |record|
  	 	 p extension = File.extname(record.image_file_name).downcase if record.image_file_name.present?
         p new_file_name = "#{record.title}#{extension}"
	  	(record.image.styles.keys+[:original]).each do |style|
	  		begin
	    	p path = record.image.path(style)
	    	p FileUtils.move(path, File.join(File.dirname(path), new_file_name))
	    	rescue e
	    		p e.error
	    	end
	    end
		record.image_file_name = new_file_name
		record.save
  end
end
end