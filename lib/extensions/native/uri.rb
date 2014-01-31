require 'uri'

module URI
  def without_query_or_fragment
    "#{self.scheme}://#{self.host}#{self.path}"
  end
  
  def host_w_out_subdomains
    self.host.match(/[^\.]+\.\w+$/).to_s
  end
end