module LessonsHelper
  def study_title(lesson=nil)
    @study.try(:title) || lesson.study.title
  end
end
