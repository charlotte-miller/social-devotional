# TODO migrate to controllers/concerns

module SourceableControllers
  
  def self.included(base)
    base.class_eval do
      
      def current_source
        case params
          when [:lesson_id]   then Lesson.find(  params[:lesson_id]  )
          when [:meeting_id]  then Meeting.find( params[:meeting_id] )
        end   
      end
      
    end    
  end
  
  
end