# ===Adds helpers for Solr-Sunspot Integration
#
module Searchable
  extend ActiveSupport::Concern
  
  
private
  def searchable_title str
    str.downcase.gsub(/^(an?|the|for|by)\b/, '').strip
  end
end