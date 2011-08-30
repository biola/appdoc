require 'rails/generators/active_record'

module ActiveRecord
  module Generators
    class AppdocGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      def generate_model
        invoke "active_record:model", [name], :migration => false
      end

      def copy_appdoc_migration
        migration_template "migration.rb", "db/migrate/appdoc_create_documents"
      end
    end
  end
end
