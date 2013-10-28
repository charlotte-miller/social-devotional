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
    
    has_attachable_file :audio, :path => ':rails_env/:class/:id/:attachment/:style/:filename',
                        :processors => [:video_to_audio]
                        # :styles => {
                        #   ogg:true, mp3:true}

    
    # http://s3.amazonaws.com/awsdocs/elastictranscoder/latest/elastictranscoder-dg.pdf
    has_attachable_file :video, :path => ':rails_env/:class/:id/:attachment/:style/:filename',
                        :processors => [:audio_to_video, :ffmpeg,],  #, :qtfaststart
                        :styles => {
                          webm:          { geometry: SD_SIZE,  :format => 'webm' },
                          mp4:           { geometry: SD_SIZE,  :format => 'mp4' , :streaming => true},

                          poster_img_hd: { geometry: HD_SIZE,  :format => 'png', :time => 8 },
                          webm_hd:       { geometry: HD_SIZE,  :format => 'webm' },
                          mp4_hd:        { geometry: HD_SIZE,  :format => 'mp4' , :streaming => true},

                          mp4_mobile:    { geometry: MOBILE_SIZE,  :format => 'mp4' , :streaming => true}}
    
    
    # TODO: add migration for poster_img attachment
    has_attachable_file :poster_img, :path => ':rails_env/:class/:id/:attachment/:style.:extension',
                        :processors => [:ffmpeg],
                        :styles => {
                          time_2:  { geometry: SD_SIZE,  :format => 'png', :time => 2  },
                          time_4:  { geometry: SD_SIZE,  :format => 'png', :time => 4  },
                          time_6:  { geometry: SD_SIZE,  :format => 'png', :time => 6  },
                          time_8:  { geometry: SD_SIZE,  :format => 'png', :time => 8  },
                          time_10: { geometry: SD_SIZE,  :format => 'png', :time => 10 },
                          time_12: { geometry: SD_SIZE,  :format => 'png', :time => 12 },
                          time_14: { geometry: SD_SIZE,  :format => 'png', :time => 14 },
                          time_16: { geometry: SD_SIZE,  :format => 'png', :time => 16 },
                          time_18: { geometry: SD_SIZE,  :format => 'png', :time => 18 },
                          time_20: { geometry: SD_SIZE,  :format => 'png', :time => 20 }}

  end
end

# Source:
# - https://github.com/owahab/paperclip-ffmpeg
# - http://docs.sublimevideo.net/encode-videos-for-the-web