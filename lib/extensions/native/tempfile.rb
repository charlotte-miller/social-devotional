# https://github.com/vidibus/vidibus-tempfile

class Tempfile
  def fetch
    return unless File.file?(path)
    self.write(File.read(path))
    self.rewind
    self
  end

  def original_filename
    File.basename(self.path)
  end

  def content_type
    mime = `file --mime -br #{self.path}`.strip
    mime.gsub!(/^.*: */,"")
    mime.gsub!(/(;|,).*$/,"")
    mime
  end

  # Replaces Tempfile's +make_tmpname+ with one that honors file extensions.
  # Copied from Paperclip
  
  # Due to how ImageMagick handles its image format conversion and how
  # Tempfile handles its naming scheme, it is necessary to override how
  # Tempfile makes # its names so as to allow for file extensions. Idea
  # taken from the comments on this blog post:
  # http://marsorange.com/archives/of-mogrify-ruby-tempfile-dynamic-class-definitions
  #
  # This is Ruby 1.9.3's implementation.
  def make_tmpname(prefix_suffix, n)
    if RUBY_PLATFORM =~ /java/
      case prefix_suffix
      when String
        prefix, suffix = prefix_suffix, ''
      when Array
        prefix, suffix = *prefix_suffix
      else
        raise ArgumentError, "unexpected prefix_suffix: #{prefix_suffix.inspect}"
      end

      t = Time.now.strftime("%y%m%d")
      path = "#{prefix}#{t}-#{$$}-#{rand(0x100000000).to_s(36)}-#{n}#{suffix}"
    else
      super
    end
  end
end