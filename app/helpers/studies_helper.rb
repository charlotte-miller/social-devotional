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
      @collection = collection
      @options = {
        rows_since_possible_repeat: 3
      }.merge(options)
      @rows = []
    end
    
    def random_grid_layout
      LAYOUT_COLUMN_COUNTS.sample
    end
    
    # Creates a visually 'random' grid 
    def rows_for(count=10)    
      count.times { @rows << find_uniq_layout }
      @rows
    end
    
  private
    def trailing_rows
      floor = [@rows.count - @options[:rows_since_possible_repeat], 0].max
      @trailing_rows_cache = Array.wrap( @rows[floor...@rows.count] )
    end
    
    def find_uniq_layout
      trailing_rows.empty? ? (return random_grid_layout) : (maybe = random_grid_layout)
      maybe = find_uniq_layout if @trailing_rows_cache.include?(maybe)
      maybe = find_uniq_layout if @trailing_rows_cache.last[0] == maybe[0]
      maybe = find_uniq_layout if @trailing_rows_cache.last[-1] == maybe[-1]
      maybe
    end
  end
end
