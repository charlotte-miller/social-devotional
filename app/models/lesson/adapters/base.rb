# === Lesson::Adapters::Base (Abstract Class)
# Provides a common interface for any lesson-source
#
class Lesson::Adapters::Base
  include ActsAsInterface

  abstract_methods :initialize
  ATTRIBUTES = [
    :title,
    :description,
    :backlink,
    :published_at,
    :duration,
    :audio_remote_url,
    :video_remote_url ]
    # :poster_img_remote_url
  attr_accessor *ATTRIBUTES

  def to_hash
    instance_variables.inject(HashWithIndifferentAccess.new) do |hash, attr|
      hash[attr[1..-1]]= instance_variable_get(attr)
      hash
    end
  end
end
