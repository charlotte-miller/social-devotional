module StudiesHelper
  GRID_LAYOUT_COLUMN_COUNTS = [ 
      [3,3,3,3],
      [4,4,4],
      [3,4,5],
      [3,3,6]
    ].inject([]) {|array,grid_width| (array | grid_width.permutation.to_a.uniq)}
  
  def random_grid_layout
    GRID_LAYOUT_COLUMN_COUNTS.sample
  end
  
  # Creates a visually 'random' grid 
  def random_grid_layouts(count=10, rows_since_possible_repeat=3)
    def find_uniq_layout
     @trailing_n_rows.empty? ? (return random_grid_layout) : (maybe = random_grid_layout)
     maybe = find_uniq_layout if @trailing_n_rows.include?(maybe)
     maybe = find_uniq_layout if @trailing_n_rows.last[0] == maybe[0]
     maybe = find_uniq_layout if @trailing_n_rows.last[-1] == maybe[-1]
     maybe
    end
    
    count.times.inject([]) do |array,index|      
      @trailing_n_rows = array[[index-rows_since_possible_repeat, 0].max...index]
      array << find_uniq_layout
    end
  end
end
