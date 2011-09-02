require "appdoc/version"

module Appdoc
  require 'appdoc/engine' if defined?(Rails)
  require 'acts-as-taggable-on'
  require 'declarative_authorization'
  require 'haml'
  require 'kaminari'
  require 'meta_search'
  
  # Settings
  mattr_accessor(:delimiter)
  mattr_accessor(:separator)
  mattr_accessor(:autocompleteValues)
  mattr_accessor(:minSearchLength)
  mattr_accessor(:placeholder)
  
  # for easy configuration
  def self.config
    yield self
  end
end
