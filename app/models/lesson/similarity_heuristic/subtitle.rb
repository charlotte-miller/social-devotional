module Lesson::SimilarityHeuristic
  class Subtitle < Base

    def matches?
      find_main_title(context.title) == find_main_title(other_lesson.title)
    end

  private
    
    def find_main_title(full_title)
      full_title
      # strips sub-title
      # return main_title
    end
    
  end
end