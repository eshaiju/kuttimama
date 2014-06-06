class PhotoComment < ActiveRecord::Base
	has_attached_file :image , :styles => { :original => "400x350>"}
end
