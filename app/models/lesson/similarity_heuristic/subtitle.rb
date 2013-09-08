module Lesson::SimilarityHeuristic
  class Subtitle < Base

    def matches?
      find_main_title(context.title) == find_main_title(other_lesson.title)
    end

  private
    
    # strips sub-title by [sub], (sub), :sub
    def find_main_title(full_title)
      main_title = full_title.scan(/^[^:\[\(\-]*/).first
      main_title
    end
    
  end
end