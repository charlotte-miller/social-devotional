# Create a video from the video + poster_image 
#
module Paperclip
  class AudioToVideo < Processor
    
    def initialize(file, options = {}, attachment = nil)
      super
      @poster_img = options[:poster_img] # File, Tempfile, 'path/to/file'
    end
    
    def make
      return file if already_video?

      # `ffmpeg -i Sample.jpg -i Sample.mp3 -vcodec libx264 result2.mp4`
      @command_line = Cocaine::CommandLine.new('ffmpeg', "-i :from_img -i :from_audio -vcodec libx264 :to_video")
      @command_line.run(from_img:poster_img_path, from_audio:file.path, to_video:destination_file.path)
      return destination_file
    end
    
  private
    def destination_file
      @destination_file ||= Tempfile.new([@basename, ".mp4"]).binmode   # Hard-coded to mp4 for libx264
    end
    
    def poster_img_path
      @poster_img ||= attachment.instance.poster_img_w_study_backfill.to_tempfile(:sd) # :original 
      
      already_a_valid_path = (@poster_img.is_a? String) && (File.exists? @poster_img)
      return @poster_img if already_a_valid_path
      @poster_img.path
    end
    
    def already_video?
      formats = %w{.m4v .mp4 .m4p .ogg .mov .webm .avi .flv .wmv}
      formats.include? file.extname
    end
  end
end