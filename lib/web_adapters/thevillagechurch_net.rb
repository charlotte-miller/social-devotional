# Probably more like a page specific scraper


require 'rubygems'
require 'anemone'

# http://anemone.rubyforge.org/information-and-examples.html
Anemone.crawl("www.thevillagechurch.net/") do |anemone|
  titles = []
  anemone.focus_crawl   { |page| page.links.slice(0..100) }
  anemone.on_every_page { |page| titles.push page.doc.at('title').inner_html rescue nil }
  anemone.after_crawl   { puts titles.compact.sort }
end