module Paperclip
  class Geometry
    def self.from_file file
      parse("100x100")
    end
  end
  class Thumbnail
    def make
      src = File.join(Rails.root, 'spec/files/user_profile_image.jpeg') #Test::FileHelper.fixture_file('white_pixel.jpg')
      dst = Tempfile.new([@basename, @format].compact.join("."))
      dst.binmode
      FileUtils.cp(src.path, dst.path)
      return dst
    end
  end
end

# module Paperclip
#   def self.run cmd, params = "", expected_outcodes = 0
#     case cmd
#     when "identify"
#       return "100x100"
#     when "convert"
#       return
#     else
#       super
#     end
#   end
# end
# 
# class Paperclip::Attachment
#   def post_process
#   end
# end