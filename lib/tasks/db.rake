namespace :db do
  desc "Rebuild Database"
  task :rebuild => [:environment] do
    [ 'db:drop',     
      'db:create',   
      'db:migrate',  
      'db:test:purge',
      'db:test:load_schema'
    ].each { |task| Rake::Task[ task ].execute  } #rescue next
  end
  
end