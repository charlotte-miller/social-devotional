#!/usr/bin/env ruby
require 'ostruct'
require 'rubygems'
require 'thor'
require 'nokogiri'
require 'haml'
require 'pry'

class Compile < Thor
  
  desc "inbox", "Process every XML file in ./inbox"
  def inbox
    FileList.new(File.join(current_dir, 'inbox/*.xml')).each do |filename|
      project(filename)
    end
  end
  
  desc "project PROJECT_XML_PATH", "Process a single project.xml file"
  def project(project_xml_path=nil)
    features = parse_features(project_xml_path)
    complile_features_haml(features)
    say "Done: #{File.basename(project_xml_path.to_s)}", :green, :force_new_line
  end
  
  desc "pivotal_project PROJECT_XML_PATH", "Generate a csv for a PivotalTracker import"
  def pivotal_project(project_xml_path=nil)
    require 'csv'   
    project = Nokogiri::XML(File.read(project_xml_path)) > 'Project'
    
    csv_headers = ["Story","Labels","Story Type","Estimate","Requested By","Description"]
    doc = CSV.generate do |csv|
      csv << csv_headers
      csv << project.to_pivotal(csv)
    end
    
    File.write('outbox/pivotal_tracker.csv', doc)
  end
  
private
  def current_dir; @dir ||= File.expand_path(File.dirname(__FILE__)) ;end
  
  def complile_features_haml(features_obj)
    outfile  = File.join(current_dir, 'outbox/index.html')
    template = File.join(current_dir, '_template.haml')
    
    def features_obj.menu_tag_builder(array)
      def self.build_list(array)
        return unless array
        haml_tag :ul, {'class'=>'group'} do
          array.each do |activity|
            haml_tag :li, {'class'=>'feature'} do
              haml_tag :a, {href:'#'} do
                haml_tag :span, activity.title
                haml_tag :div, activity.description, {'class'=>'description', style:'display:none;'}
                Array(activity.images).each do |img|
                  haml_tag :img, {
                    'class'=>'wireframe', 
                    src:"assets/wireframes/#{img}.png", 
                    href:"assets/wireframes/#{img}.png", 
                    'data-gall'=>activity.title,
                    style:"display:none;"}
                end
              end
              build_list(activity.children)
            end
          end
        end
      end

      capture_haml do
        self.build_list(array)
      end
    end
    
    File.open(outfile, 'w') do |f|
      f.write Haml::Engine.new(File.read(template)).render(features_obj)
    end
  end
  
  # returns features_obj
  def parse_features(project_xml_path)
    project = Nokogiri::XML(File.read(project_xml_path)) > 'Project'
    
    
    
    OpenStruct.new({
      title: "Features: #{File.basename(project_xml_path.to_s)}",
      features: project.to_struct
    })
  end
  
  # Custom Enhancements
  class Nokogiri::XML::NodeSet
    def to_hash;   self.map(&:to_hash)    ;end
    def to_struct; self.map(&:to_struct)  ;end
    def to_pivotal(csv)
      self.inject([]) do |master_array, node|
        csv << node.to_pivotal(csv)
        node.child_activities.to_pivotal(csv)
      end
    end 
  end
  
  class Nokogiri::XML::Element
    
    def child_activities
      self > 'Activity'
    end
    
    def attached_images
      (self > 'elements' > 'File').map {|file| file.pluck(:title)}
    end
    
    def pluck key
      (self > key.to_s).inner_html
    end
    
    def to_hash
      hash = { title: pluck(:title), description: pluck(:description)}
      hash.merge!({ images:   attached_images })           unless attached_images.empty?
      hash.merge!({ children: child_activities.to_hash })  unless child_activities.empty?
      hash
    end
    
    def to_struct
      struct = OpenStruct.new({ title: pluck(:title), description: pluck(:description)})
      struct.images   = attached_images             unless attached_images.empty?
      struct.children = child_activities.to_struct  unless child_activities.empty?
      struct
    end
    
    def to_pivotal(csv)    
      # ["Story","Labels","Story Type","Estimate","Requested By","Description"]
      labels = self.ancestors.map {|node| node.pluck('title') if node.is_a? Nokogiri::XML::Element}.compact.join(',')
      [pluck(:title),labels, 'Feature',nil,'Chip',pluck(:description)]
    end
  end
  
end

Compile.start(ARGV)