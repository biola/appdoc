require 'rails/generators'
require 'rails/generators/migration'

class AppdocGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.join(File.dirname(__FILE__), 'templates')

  def self.next_migration_number(dirname)
    sleep 1
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  def create_migration_files
    migration_template "migration.rb", "db/migrate/appdoc_create_documents"
    run "rails generate acts_as_taggable_on:migration"
  end
  
  def create_initializer
    template 'appdoc_config.rb', 'config/initializers/appdoc_config.rb'
  end
  
  def copy_related_files
    copy_file 'public/stylesheets/jquery/smart_text_box/SmartTextBox.css', 'public/stylesheets/jquery/smart_text_box/SmartTextBox.css'
    copy_file 'public/stylesheets/jquery/smart_text_box/imgs/close.gif', 'public/stylesheets/jquery/smart_text_box/imgs/close.gif'
    copy_file 'public/javascripts/SmartTextBox.js', 'public/javascripts/SmartTextBox.js'
  end
end
