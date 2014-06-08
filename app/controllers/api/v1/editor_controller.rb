class Api::V1::EditorController < Api::ApiController
  require 'securerandom'


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
    output_file = convert_text_to_image text,fond_size,color,width,weight,background_color,@photo,position_x,position_y
    @photo.destroy
    render :status => :ok,:json =>{:image_path =>"#{HOST_URL}/converted_images/#{output_file}"}
  end

  def convert_text_to_image text,fond_size,color,width,weight,background_color,photo,position_x,position_y
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
    second_image_path = title.filename
    first_image_path =  photo.image.url.split('?')[0]
    first_image = MiniMagick::Image.open "public#{first_image_path}"
    second_image = MiniMagick::Image.open "public/#{second_image_path}"

    result = first_image.composite(second_image) do |c|
      c.compose "Over" # OverCompositeOp
      c.geometry "+#{position_x}+#{position_y}" # copy second_image onto first_image from (20, 20)
    end
    output_file = SecureRandom.hex + "jpg"
    result.write "public/converted_images/#{output_file}"
    `rm public/#{second_image_path}`
    output_file
  end
end