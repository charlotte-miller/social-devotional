require 'spec_helper'

module Lesson::SimilarityHeuristic
  describe NumericTitle do
    
    describe '#maches?' do
      it "matches lessons that differ ONLY by a number" do
        matching_title_pairs = [
          ['Mark Part 1', 'Mark Part 2'],
          ['Mark [Part 1]', 'Mark [Part 2]'],
          ['Mark (Part 1)', 'Mark (Part 2)'],
          ['Mark Part I', 'Mark Part II'],
        ].each do |title_pair|
          part_1, part_2 = title_pair.map {|title| build_stubbed(:lesson, title:title)}
          (NumericTitle.new(part_1, part_2).matches?).should be_true
        end

        non_matching_title_pairs = [
          ['Mark Part 1', 'Moses Part 1']
        ].each do |title_pair|
          part_1, part_2 = title_pair.map {|title| build_stubbed(:lesson, title:title)}
          (NumericTitle.new(part_1, part_2).matches?).should be_false
        end
      end
    end
    
  end
end
