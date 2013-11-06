# TODO
class Lesson::PosterMaker < ActiveRecord::Base
  include AttachableFile
  belongs_to :lesson
  
  # Creates a series of possible poster images from a video (SD/HD)
  # - include the studies poster_img
  # Stores the correct (user's) choice
  # Clears the others after a few weeks 
  
  
  # # TODO: add migration for poster_img_options:attachment img_selection:integer
  # has_attachable_file :img_options, :path => ':rails_env/:class/:id/:attachment/:style.:extension',
  #                     :processors => [:ffmpeg],
  #                     :styles => {
  #                       sd_2:  { geometry: Lesson::AttachedMedia::SD_SIZE,  :format => 'png', :time => 2  },
  #                       sd_4:  { geometry: Lesson::AttachedMedia::SD_SIZE,  :format => 'png', :time => 4  },
  #                       sd_6:  { geometry: Lesson::AttachedMedia::SD_SIZE,  :format => 'png', :time => 6  },
  #                       sd_8:  { geometry: Lesson::AttachedMedia::SD_SIZE,  :format => 'png', :time => 8  },
  #                       sd_10: { geometry: Lesson::AttachedMedia::SD_SIZE,  :format => 'png', :time => 10 },
  #                       sd_12: { geometry: Lesson::AttachedMedia::SD_SIZE,  :format => 'png', :time => 12 },
  #                       sd_14: { geometry: Lesson::AttachedMedia::SD_SIZE,  :format => 'png', :time => 14 },
  #                       sd_16: { geometry: Lesson::AttachedMedia::SD_SIZE,  :format => 'png', :time => 16 },
  #                       sd_18: { geometry: Lesson::AttachedMedia::SD_SIZE,  :format => 'png', :time => 18 },
  #                       sd_20: { geometry: Lesson::AttachedMedia::SD_SIZE,  :format => 'png', :time => 20 }}
  #                       # poster_img_hd: { geometry: Lesson::AttachedMedia::HD_SIZE,  :format => 'png', :time => 8 },                       
end