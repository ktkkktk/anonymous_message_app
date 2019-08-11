class UserMailer < ApplicationMailer

  # constants to card images
  IMAGE_WIDTH = 600
  NUM_OF_CHAR_IN_A_LINE = 38 
  FONT_SIZE = 14
  FONT_NAME = 'app/assets/fonts/FLOPDesignFont.ttf'
  LINE_HEIGHT = 20
  TEMP_IMAGE_DIR_PATH = "app/assets/images/"
  FRAME_COLOR = '#FFED8C'
  
  
  def message_card(user)
    @user = user
    @content = user.message_cards.last.content
    @card_image_file_name =  uniq_file_name
    card_image_file_with_path = TEMP_IMAGE_DIR_PATH + @card_image_file_name
    create_card_image card_image_file_with_path, @content
    
    # set attachment file
    attachments.inline[@card_image_file_name] = { content: File.read("#{Rails.root}/#{card_image_file_with_path}") }
    mail to: user.email, subject: "メッセージカードが届きました！"
    FileUtils.rm(card_image_file_with_path)
  end
  
  private
    def uniq_file_name
      "#{SecureRandom.hex}.png"
    end
    
    def create_card_image(file_name, content)
      lines = (content.size / NUM_OF_CHAR_IN_A_LINE.to_f).ceil
      image_height = 60 + LINE_HEIGHT * lines
      frame_color = FRAME_COLOR
      
      create_empty_card file_name, image_height, frame_color
      add_text_to_card file_name, content
    end
    
    def create_empty_card(file_name, image_height, frame_color)
      MiniMagick::Tool::Convert.new do |i|
        i.size "#{IMAGE_WIDTH}x#{image_height}"
        i.canvas frame_color
        i << '-fill' << '#FFFFFF'
        i << '-draw' << "roundRectangle 20, 20, #{IMAGE_WIDTH - 20}, #{image_height - 20}, 20, 20"
        i << file_name
      end
    end
    
    def add_text_to_card(file_name, content)
      # add text
      splitted_content = content.scan(/.{1,#{NUM_OF_CHAR_IN_A_LINE}}/)
      splitted_content.each_with_index do |text, i|
        @image = MiniMagick::Image.open(file_name)
        @image.combine_options do |config|
          config.font FONT_NAME
          # config << '-font' << 'Noto Sans JP'
          config.gravity 'North-West'
          config.pointsize FONT_SIZE
          config << '-annotate' << "+30+#{30 + LINE_HEIGHT * i}" << "#{text}"
        end
        @image.write file_name
      end
    end
end
