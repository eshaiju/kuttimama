class Api::V1::EditorController < Api::ApiController
	def create
    text = params[:text]
    @photo =  PhotoComment.create(:image =>params[:image])
    @photo.save
    @photo = PhotoComment.last
    first_image_path =  @photo.image.url.split('?')[0]
    fond_size = params[:font_size]
    position_x = params[:x]
    position_y = params[:y]
    color = "#"+params[:color] || "#FFFF"
    width = params[:width] || 800
    weight = params[:weight] || 800
    title = MagickTitle.say(text,
							:font_size => fond_size,
							:color => color,
							:destination => Proc.new{ File.join MagickTitle.root, "public" },
							:width => width,
							:weight => weight
							)
    seccond_image_path = title.filename
    first_image = MiniMagick::Image.open "public#{first_image_path}"
    second_image = MiniMagick::Image.open "public/#{seccond_image_path}"

  	result = first_image.composite(second_image) do |c|
  	  c.compose "Over" # OverCompositeOp
  	  c.geometry "+#{position_x}+#{position_y}" # copy second_image onto first_image from (20, 20)
  	end
  	result.write 'public/output.jpg'
    render :status => :ok,:json =>{:image_path =>"#{HOST_URL}/output.jpg"}
  end
end