require 'spec_helper'

module Lesson::SimilarityHeuristic
  describe Subtitle do
    
    describe '#maches?' do
      it "matches lessons that differ ONLY the Subtitle" do
        matching_title_pairs = [
          ['Sins: Lust',  'Sins: Gluttony:'],
          ['Sins [Lust]', 'Sins [Gluttony]'],
          ['Sins (Lust)', 'Sins (Gluttony)'],
          ['Sins - Lust', 'Sins - Gluttony'],
        ].each do |title_pair|
          part_1, part_2 = title_pair.map {|title| build_stubbed(:lesson, title:title)}
          (Subtitle.new(part_1, part_2).matches?).should be_true
        end

        non_matching_title_pairs = [
          ['St. Mark', 'St. Matthew']
        ].each do |title_pair|
          part_1, part_2 = title_pair.map {|title| build_stubbed(:lesson, title:title)}
          (Subtitle.new(part_1, part_2).matches?).should be_false
        end
      end
    end
  end
end