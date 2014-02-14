require 'spec_helper'

describe StudiesHelper do
  
  describe "#random_grid_layout" do
    it "grabs a random sample of GRID_LAYOUT_COLUMN_COUNTS" do
      StudiesHelper::GRID_LAYOUT_COLUMN_COUNTS.should include helper.random_grid_layout
    end
  end
  
  describe "#random_grid_layouts(count=10, rows_since_possible_repeat=3)" do
    before(:all){ @orig_verbose, $VERBOSE = $VERBOSE, nil }
    after(:all){ $VERBOSE = @orig_verbose}
    
    it "returns N samples of GRID_LAYOUT_COLUMN_COUNTS" do
      helper.random_grid_layouts(5).should have(5).items
      helper.random_grid_layouts(5).each do |layout|
        StudiesHelper::GRID_LAYOUT_COLUMN_COUNTS.should include layout
      end
    end
    
    it "does not repeat for 'rows_since_possible_repeat'" do
      StudiesHelper::GRID_LAYOUT_COLUMN_COUNTS = [[1], [2], [3]] # length must be > rows_since_possible_repeat
      helper.random_grid_layouts(6, 2).flatten.sort.should eq [1,1,2,2,3,3]
    end
    
    it "does not allow immediately repeated values for first/last value" do
      (layouts = helper.random_grid_layouts(50)).each_with_index do |layout, index|
        next if index == 0
        trailing_layout = layouts[index-1]
        trailing_layout[0].should_not  eql layout[0]
        trailing_layout[-1].should_not eql layout[-1]
      end
    end
  end
end
