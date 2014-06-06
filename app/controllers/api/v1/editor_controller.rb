class Api::V1::EditorController < Api::ApiController
	def create
    @photo =  PhotoComment.create(:image =>params[:image])
    @photo.save
    @photo = PhotoComment.last
    text = params[:text]
    fond_size = params[:font_size]
    position_x = params[:x]
    position_y = params[:y]
    color = "#"+params[:color] || "#FFFF"
    background_color = params[:background_color] || '#ffffff'
    width = params[:width] || 800
    weight = params[:weight] || 800
    convert_text_to_image text,fond_size,color,width,background_color,@photo,position_x,position_y
    @photo.destroy
    render :status => :ok,:json =>{:image_path =>"#{HOST_URL}/output.jpg"}
  end

  def convert_text_to_image text,fond_size,color,width,background_color,photo,position_x,position_y
    title = MagickTitle.say(text,
              :font_size => fond_size,
              :color => color,
              :destination => Proc.new{ File.join MagickTitle.root, "public" },
              :width => width,
              :weight => weight,
              :background_color => background_color,
              :font =>'AnjaliOldLipi.ttf',
              :font_path =>'public/fonts'
              )
    seccond_image_path = title.filename
    first_image_path =  photo.image.url.split('?')[0]
    first_image = MiniMagick::Image.open "public#{first_image_path}"
    second_image = MiniMagick::Image.open "public/#{seccond_image_path}"

    result = first_image.composite(second_image) do |c|
      c.compose "Over" # OverCompositeOp
      c.geometry "+#{position_x}+#{position_y}" # copy second_image onto first_image from (20, 20)
    end
    result.write 'public/output.jpg'
  end
end