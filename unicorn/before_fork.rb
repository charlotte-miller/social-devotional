# Need to reinitialize our database connection 
ActiveRecord::Base.connection.disconnect!
