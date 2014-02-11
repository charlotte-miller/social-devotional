module StudiesHelper
  
  def random_column_layout
    @rows ||= [ 
      [3,3,3,3],
      [4,4,4],
      [3,4,5],
      [3,3,6]
    ].inject([]) {|array,grid_width| (array | grid_width.permutation.to_a.uniq)}
    @rows.sample
  end
  
  def random_column_layouts(count=10, rows_since_possible_repeat=3)
    count.times.inject([]) do |array,index|
      trailing_n_rows = array[[index-rows_since_possible_repeat, 0].max...index]
    
      layout = random_column_division
      while trailing_n_rows.include?(layout); layout = random_column_division ;end
      array << layout
    end
  end
end
