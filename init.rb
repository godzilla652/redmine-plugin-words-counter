require 'redmine'
require_dependency 'words/hooks'

Redmine::Plugin.register :words do
  name 'Words Counter plugin'
  author 'boo'
  description 'counts words in file attached to an issue'
  version '1.0.0'
    
  menu :admin_menu, :words, { :controller => 'words', :action => 'index' }, :caption => 'Word Counter Plugin'
end
