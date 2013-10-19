# === Configuration for processing & storing a Lesson's audio/video files. 
# - Uses the AttachableFile module
# - Uses paperclip-ffmpeg for transcoding
#
module Lesson::AttachedMedia
  extend  ActiveSupport::Concern
  include AttachableFile
  included do
    
    # Video Dimensions
    SD_SIZE     = '640x360#'
    HD_SIZE     = '1280x720#'
    MOBILE_SIZE = '480x270#'
    
    has_attachable_file :audio, :path => ':rails_env/:class/:attachment/:updated_at-:basename.:extension',
                        :processors => []
                        # :styles => {ogg:true, mp3:true}

    has_attachable_file :video, :path => ':rails_env/:class/:attachment/:updated_at-:basename.:extension',
                        :processors => [:ffmpeg, :qtfaststart],
                        :styles => {
                          poster_img:    { geometry: SD_SIZE,  :format => 'png', :time => 8 },
                          webm:          { geometry: SD_SIZE,  :format => 'webm' },
                          mp4:           { geometry: SD_SIZE,  :format => 'mp4' , :streaming => true},

                          poster_img_hd: { geometry: HD_SIZE,  :format => 'png', :time => 8 },
                          webm_hd:       { geometry: HD_SIZE,  :format => 'webm' },
                          mp4_hd:        { geometry: HD_SIZE,  :format => 'mp4' , :streaming => true},

                          mp4_mobile:    { geometry: MOBILE_SIZE,  :format => 'mp4' , :streaming => true}}

  end
end

# Source:
# - https://github.com/owahab/paperclip-ffmpeg
# - http://docs.sublimevideo.net/encode-videos-for-the-web