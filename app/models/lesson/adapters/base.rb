# === Lesson::Adapters::Base (Abstract Class)
# Provides a common interface for any lesson-source
#
module Lesson::Adapters
  class Invalid  < StandardError; end
  class NotFound < StandardError; end

  class Base
    include Sanitizable
    include ActsAsInterface
    include ActiveModel::Validations

    abstract_methods :initialize
    attr_accessor *ATTRIBUTES = [
      :title,
      :description,
      :author,
      :backlink,
      :published_at,
      :duration,
      :audio_remote_url,
      :video_remote_url,
      :poster_img_remote_url ]

      validates_presence_of *ATTRIBUTES  #does NOT raise on initialize

    def to_hash
      raise Invalid.new(@errors.messages) if invalid?
      ATTRIBUTES.inject(HashWithIndifferentAccess.new) {|hash, attr| hash[attr]= send(attr); hash }
    end
  end
end
