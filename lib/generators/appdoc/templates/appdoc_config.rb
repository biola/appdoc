Appdoc.config do |config|
  config.delimiter = " "  #changing this line may affect the functionality of this gem.
  config.autocompleteValues = ["dashboard", "users"]
  config.minSearchLength = 2
  config.placeholder = "Start typing for suggested tags"
end
