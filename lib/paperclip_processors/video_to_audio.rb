# Extract the audio track from a video
#
module Paperclip
  class VideoToAudio < Processor
    
    def make
      return file if already_audio?
      # TODO: Do the conversion
      file
    end
    
  private
    # def tempfiled
    #   src = @file
    #   dst = Tempfile.new([@basename, @format ? ".#{@format}" : ''])
    #   dst.binmode
    #   dst
    # end

    def already_audio?
      formats = %w{.ogg .mp3 .mp2 .acc .wav}
      formats.include? File.extname(file.basename)  #original_filename
    end
  end
end