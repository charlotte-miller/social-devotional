# Create a video from the video + poster_image 
#
module Paperclip
  class AudioToVideo < Processor
    
    def make
      return file if already_video?
      # TODO: Do the conversion
      file
    end
    
  private
    def poster_img
      attachment.instance.poster_img
    end
    
    def already_video?
      formats = %w{.m4v .mp4 .m4p .ogg .mov .webm .avi .flv .wmv}
      formats.include? file.extname
    end
  end
end