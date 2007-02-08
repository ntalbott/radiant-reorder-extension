namespace :radiant do
  namespace :extensions do
    namespace :reorder do
      
      desc "Runs the migration of the Reorder extension"
      task :migrate do
        require 'extension_migrator'
        if ENV["VERSION"]
          ReorderExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          ReorderExtension.migrator.migrate
        end
      end
    
    end
  end
end