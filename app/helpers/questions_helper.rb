module QuestionsHelper
  
  def polymorphic_questions_path( question_or_action=nil )
    raise ArgumentError.new('requires @lesson or @meeting') unless @lesson || @meeting
    
    question = question_or_action.is_a?( Question ) ? question_or_action : 'questions'
    obj_array = [@study, @lesson, @group, @meeting, question].compact
    
    case question_or_action
      when 'new'    
        obj_array[-1] = obj_array[-1].singularize
        new_polymorphic_path( obj_array )
      # not edit
      
      when Question
        question_path(question) #shallow routes

      else  polymorphic_path( obj_array )
    end
  end
  
end
