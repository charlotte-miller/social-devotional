module StudiesHelper
  
  # Creates a visually 'random' grid (well hash of column widths)
  # #=> [ # Study is the key
  #       {<#Study>:4, <#Study>:4, <#Study>:4},
  #       {<#Study>:3, <#Study>:3, <#Study>:3, <#Study>:3},
  #     ]
  def grid_layout_for(collection, options={})
    GridLayout.new(collection, options).as_json
  end
  
  class GridLayout
    LAYOUT_COLUMN_COUNTS = [ 
        [3,3,3,3],
        [4,4,4],
        [3,4,5],
        [3,3,6]
      ].inject([]) {|array,grid_width| (array | grid_width.permutation.to_a.uniq)}
    
    def initialize(collection, options={})
      @rows = []
      @collection = @pristine_collection = collection
      @options = { rows_since_possible_repeat: 3, tidy_ending:true }.merge(options)
    end
    
    def as_json
      collection_to_rows.inject([]) do |array, row_array|
        array << row_array.inject({}){|hash, col| hash[ @collection.shift]=col; hash}
      end
    end
    
  private
    
    def collection_to_rows
      while remaining_collection_items > 0
        @rows << find_uniq_layout
      end
      @rows
    end
    
    def find_uniq_layout
      return tidy_ending      if @options[:tidy_ending] && tidy_ending
      return random_grid_row  if trailing_rows.empty?
        
      maybe = random_grid_row
      maybe = find_uniq_layout if @trailing_rows_cache.include?(maybe)
      maybe = find_uniq_layout if @trailing_rows_cache.last[0] == maybe[0]
      maybe = find_uniq_layout if @trailing_rows_cache.last[-1] == maybe[-1]
      yes   = maybe
    end
        
    # Establishes a 'no repeat' zone
    def trailing_rows
      floor = [@rows.count - @options[:rows_since_possible_repeat], 0].max
      @trailing_rows_cache = Array.wrap( @rows[floor...@rows.count] )
    end
    
    def tidy_ending
      case remaining_collection_items
        when 1 then [12]
        when 2 then [7,5]
        when 4 then [3,3,3,3]
        else false
      end
    end
    
    def random_grid_row
      LAYOUT_COLUMN_COUNTS.sample
    end
    
    def remaining_collection_items
      @pristine_collection.count - @rows.flatten.count
    end
  end
end
