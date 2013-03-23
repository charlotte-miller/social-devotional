module QuestionsHelper
  
  def polymorphic_questions_path( question_or_action=nil )
    question = question_or_action.is_a?( Question ) ? question_or_action : 'questions'
    obj_array = [@study, @lesson, @group, @meeting, question].compact
    
    case question_or_action
      when 'new'    
        obj_array[-1] = obj_array[-1].singularize
        new_polymorphic_path( obj_array )
      when Question #shallow routes
        question_path(question)
      # not edit
      else  polymorphic_path( obj_array )
    end
  end
  
end
