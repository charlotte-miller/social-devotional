# Create a video from the video + poster_image 
#
module Paperclip
  class AudioToVideo < Processor
    
    def make
      return file if already_video?
      # TODO: Do the conversion
    end
    
  private
    def poster_img
      attachment.instance.poster_img
    end
    
    def already_video?
      formats = %w{.m4v .mp4 .ogg .mov .webm .avi .flv .wmv}
      formats.include? File.extname(file.basename) # original_filename
    end
  end
end