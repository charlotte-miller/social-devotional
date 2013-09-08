namespace :db do
  desc "Rebuild Database"
  task :rebuild => [:environment] do
    [ 'db:drop',     
      'db:create',   
      'db:migrate',  
      'db:test:purge',
      'db:test:load_schema',
      # 'parallel:prepare'
      # 'db:seed'
    ].each { |task| Rake::Task[ task ].execute  } #rescue next
    # `annotate -f before`
  end
  
end
