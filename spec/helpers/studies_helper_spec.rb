require 'spec_helper'

describe StudiesHelper do
  let(:collection) { (1..5).to_a }
    
  describe "grid_layout_for(collection, options={})" do
    let(:collection) { 3.times.map {build_stubbed :study} }
    
    it "returns a JSON structure (as_json)" do
      grid = helper.grid_layout_for(collection)
      grid.should be_a Array
      grid.first.should be_a Hash
      grid.first.keys.first.should be_a Study
      grid.first.values.first.should be_a Integer
    end
  end
  
  describe '::GridLayout' do
    subject { StudiesHelper::GridLayout.new((@collection || collection), (@options || {})) }
    
    describe "as_json" do      
      #   [  # Study is the key
      #     {<#Study>:4, <#Study>:4, <#Study>:4},
      #     {<#Study>:3, <#Study>:3, <#Study>:3, <#Study>:3},
      #   ]
      it "returns a JSON structure" do
        @collection = 3.times.map {build_stubbed :study}
        grid = subject.as_json
        grid.should be_a Array
        grid.first.should be_a Hash
        grid.first.keys.first.should be_a Study
        grid.first.values.first.should be_a Integer
      end
    end
    
    describe "[private]" do
      describe "#random_grid_row" do
        it "grabs a random sample of LAYOUT_COLUMN_COUNTS" do
          StudiesHelper::GridLayout::LAYOUT_COLUMN_COUNTS.should include subject.bypass.random_grid_row
        end
      end
    
      describe "#collection_to_rows" do
        before(:all){ @orig_verbose, $VERBOSE = $VERBOSE, nil }
        after(:all){ $VERBOSE = @orig_verbose}
        before(:each) { @options={tidy_ending:false}}
    
        it "returns N samples of LAYOUT_COLUMN_COUNTS" do
          subject.bypass.collection_to_rows.should have(2).items # 5 items always spread to 2 rows 
          subject.bypass.collection_to_rows.each do |layout|
            StudiesHelper::GridLayout::LAYOUT_COLUMN_COUNTS.should include layout
          end
        end
    
        it "does not repeat for 'rows_since_possible_repeat'" do
          StudiesHelper::GridLayout::LAYOUT_COLUMN_COUNTS = [[1], [2], [3]] # length must be > rows_since_possible_repeat
          @options = { rows_since_possible_repeat: 2, tidy_ending:false}
          @collection = (1..6).to_a
          subject.bypass.collection_to_rows.flatten.sort.should eq [1,1,2,2,3,3]
        end
    
        it "does not allow immediately repeated values for first/last value" do
          @collection = (1..50).to_a
          (layouts = subject.bypass.collection_to_rows).each_with_index do |layout, index|
            next if index == 0
            trailing_layout = layouts[index-1]
            trailing_layout[0].should_not  eql layout[0]
            trailing_layout[-1].should_not eql layout[-1]
          end
        end
      
        it "has a tidy ending (no partial row)" do
          StudiesHelper::GridLayout.new(1.times.map).bypass.collection_to_rows.last.should eq [12]
          StudiesHelper::GridLayout.new(2.times.map).bypass.collection_to_rows.last.should eq [7,5]
          StudiesHelper::GridLayout.new(4.times.map).bypass.collection_to_rows.last.should eq [3,3,3,3]
        end
      end
    end

  end
end
