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
    
    has_attachable_file :audio, :path => ':rails_env/:class/:id/:attachment/:style/:filename', # :hash.:extension
                        :hash_data  => ":class/:attachment/:id/:style",
                        :s3_host_alias => AppConfig.domains.media,
                        :processors => [:video_to_audio],
                        :styles => {mp3:{audio_bitrate:'64k'}}, #ogg:true
                        :default_style => :mp3

    
    # http://s3.amazonaws.com/awsdocs/elastictranscoder/latest/elastictranscoder-dg.pdf
    has_attachable_file :video, :path => ':rails_env/:class/:id/:attachment/:style/:filename', # :hash.:extension
                        :hash_data  => ":class/:attachment/:id/:style",
                        :s3_host_alias => AppConfig.domains.media,
                        :processors => [:audio_to_video, :ffmpeg, :qtfaststart],
                        :skip_processing_urls => ['youtube.com', 'vimeo.com'],
                        :default_style => :mp4,
                        :styles => {
                          webm:          { geometry: SD_SIZE,  :format => 'webm' },
                          mp4:           { geometry: SD_SIZE,  :format => 'mp4' , :streaming => true},

                          webm_hd:       { geometry: HD_SIZE,  :format => 'webm' },
                          mp4_hd:        { geometry: HD_SIZE,  :format => 'mp4' , :streaming => true},

                          mp4_mobile:    { geometry: MOBILE_SIZE,  :format => 'mp4' , :streaming => true}}
    

    
    has_attachable_file :poster_img, :path => ':rails_env/:class/:id/:attachment/:hash.:extension',
                        :hash_data => ":class/:attachment/:id/:fingerprint-:style",
                        # :processors      => [:thumbnail, :pngquant],
                        :default_style => :sd,
                        :styles => {
                          sd:     { geometry: SD_SIZE,     format: 'png', convert_options: "-strip" },
                          hd:     { geometry: HD_SIZE,     format: 'png', convert_options: "-strip" },
                          mobile: { geometry: MOBILE_SIZE, format: 'png', convert_options: "-strip" }}

  end #included


  # ---------------------------------------------------------------------------------
  # Methods
  # ---------------------------------------------------------------------------------
  
  def poster_img_w_study_backfill
    return poster_img if self.poster_img.present?
    study.poster_img
  end
  
private

  # the audio_to_video processor requires :poster_img
  def process_poster_img_first
    return unless Array.wrap(@attachments_for_processing).include? :poster_img
    @attachments_for_processing.delete(:poster_img) && @attachments_for_processing.unshift(:poster_img)
  end

end

# Source:
# - https://github.com/owahab/paperclip-ffmpeg
# - http://docs.sublimevideo.net/encode-videos-for-the-web