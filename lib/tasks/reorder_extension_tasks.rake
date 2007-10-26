namespace :radiant do
  namespace :extensions do
    namespace :reorder do
      
      desc "Runs the migration of the Reorder extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          ReorderExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          ReorderExtension.migrator.migrate
        end
      end
    
      namespace :update do
        desc "Copies the public assets of the Reorder extension into the instance's public directory"
        task :public => :environment do
          is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
          Dir[ReorderExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
            path = file.sub(ReorderExtension.root, '')
            directory = File.dirname(path)
            puts "Copying #{path}..."
            mkdir_p RAILS_ROOT + directory
            cp file, RAILS_ROOT + path
          end
        end
      end
      
    end
  end
end
