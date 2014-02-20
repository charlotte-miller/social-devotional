require 'spec_helper'

describe StudiesHelper, :focus do
    
  describe "grid_layout_for(collection, options={})" do
    
  end
  
  describe '::GridLayout' do
    let(:collection) { (1..5).to_a }
    subject { StudiesHelper::GridLayout.new(collection, (@options || {})) }
    
    describe "#random_grid_layout" do
      it "grabs a random sample of LAYOUT_COLUMN_COUNTS" do
        StudiesHelper::GridLayout::LAYOUT_COLUMN_COUNTS.should include subject.random_grid_layout
      end
    end
    
    describe "#rows_for(count=10, rows_since_possible_repeat=3)" do
      before(:all){ @orig_verbose, $VERBOSE = $VERBOSE, nil }
      after(:all){ $VERBOSE = @orig_verbose}
    
      it "returns N samples of LAYOUT_COLUMN_COUNTS" do
        subject.rows_for(5).should have(5).items
        subject.rows_for(5).each do |layout|
          StudiesHelper::GridLayout::LAYOUT_COLUMN_COUNTS.should include layout
        end
      end
    
      it "does not repeat for 'rows_since_possible_repeat'" do
        StudiesHelper::GridLayout::LAYOUT_COLUMN_COUNTS = [[1], [2], [3]] # length must be > rows_since_possible_repeat
        @options = { rows_since_possible_repeat: 2}
        subject.rows_for(6).flatten.sort.should eq [1,1,2,2,3,3]
      end
    
      it "does not allow immediately repeated values for first/last value" do
        (layouts = subject.rows_for(50)).each_with_index do |layout, index|
          next if index == 0
          trailing_layout = layouts[index-1]
          trailing_layout[0].should_not  eql layout[0]
          trailing_layout[-1].should_not eql layout[-1]
        end
      end
    end
  end
end
