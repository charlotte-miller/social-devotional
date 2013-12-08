require 'uri'

module URI
  def without_query_or_fragment
    "#{self.scheme}://#{self.host}#{self.path}"
  end
end