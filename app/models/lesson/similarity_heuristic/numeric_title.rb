# Matches Lessons based on title equality after controlling for numbers
# Example: "Roman Road Part 1" matches "Roman Road Part 2"
#
module Lesson::SimilarityHeuristic
  class NumericTitle < Base

    def matches?
      scrub_numbers(context.title) == scrub_numbers(other_lesson.title)
    end

  private

    def scrub_numbers( dirty )
      roman_num = /(X{0,2})(IX|IV|V?I{1,3})?/ #up to 30
      clean = dirty.strip.gsub(/\d/, '')
      clean = clean.gsub(/\s#{roman_num}/,'')
    end
  end
end