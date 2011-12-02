require "appdoc/version"

module Appdoc
  require 'appdoc/engine' if defined?(Rails)
  require 'action_links'
  require 'acts-as-taggable-on'
  require 'haml'
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
