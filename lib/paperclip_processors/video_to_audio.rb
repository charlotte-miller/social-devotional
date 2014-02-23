# Extract the audio track from a video
#
module Paperclip
  class VideoToAudio < Processor
    
    def initialize(file, options = {}, attachment = nil)
      super
      @audio_bitrate = options[:audio_bitrate]  || '128k'
      @format        = options[:format]         || 'mp3'
      @is_stereo     = options[:is_stereo].nil? ?  true : options[:is_stereo]
    end
    
    def make
      return file if already_audio?
      
      # `ffmpeg -i INPUT.avi -vn -ar 44100 -ac 2 -ab 128k -f mp3 OUTPUT.mp3 -y`
      @command_line = Cocaine::CommandLine.new('ffmpeg', "-i :from_video -vn -ar 44100 -ac :audio_channels -ab :audio_bitrate -f :format :to_audio -y")
      @command_line.run(from_video:file.path, to_audio:destination_file.path, audio_bitrate:@audio_bitrate, format:@format, audio_channels:audio_channels.to_s)
      return destination_file
    end
    
  private
    def destination_file
      @destination_file ||= Tempfile.new([@basename, ".#{@format}"]).binmode
    end

    def already_audio?
      formats = %w{.ogg .mp3 .mp2 .acc .wav .m4a}
      formats.include? file.extname  #original_filename
    end
    
    def audio_channels
      (@is_stereo ? 2 : 1)
    end
  end
end