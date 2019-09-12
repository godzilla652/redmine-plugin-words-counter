# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html


get 'words', :to => 'words#index'
post 'words/set_rules', :to => 'words#set_rules'
post 'words/set_message', :to => 'words#set_message'