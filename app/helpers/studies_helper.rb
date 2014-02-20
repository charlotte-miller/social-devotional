module StudiesHelper
  
  def grid_layout_for(collection, options={})
    GridLayout.new(collection, options).rows
  end
  
  class GridLayout
    LAYOUT_COLUMN_COUNTS = [ 
        [3,3,3,3],
        [4,4,4],
        [3,4,5],
        [3,3,6]
      ].inject([]) {|array,grid_width| (array | grid_width.permutation.to_a.uniq)}
    
    def initialize(collection, options={})
      options = {
        rows_since_possible_repeat: 3
      }.merge(options)
      
      @collection = collection
      @rows = []
    end
    
    def random_grid_layout
      LAYOUT_COLUMN_COUNTS.sample
    end
    
    # Creates a visually 'random' grid 
    def rows_for(count=10, rows_since_possible_repeat=3)    
      count.times.inject([]) do |array,index|      
        @trailing_n_rows = array[[index-rows_since_possible_repeat, 0].max...index]
        array << find_uniq_layout
      end
    end
    
  private
    def find_uniq_layout
      @trailing_n_rows.empty? ? (return random_grid_layout) : (maybe = random_grid_layout)
      maybe = find_uniq_layout if @trailing_n_rows.include?(maybe)
      maybe = find_uniq_layout if @trailing_n_rows.last[0] == maybe[0]
      maybe = find_uniq_layout if @trailing_n_rows.last[-1] == maybe[-1]
      maybe
    end
  end
end
