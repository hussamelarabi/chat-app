Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"

  #Application Routing
  get '/applications/get_all_apps', to: 'applications#get_all'
  get '/applications//:token/', to: 'applications#find_by_token'
  post '/applications/create_app', to: 'applications#create'
  put '/applications/:token', to: 'applications#update'

  #Chat Routing
  get '/applications/:token/chats', to: 'chats#get_chats'
  get '/applications/:token/chats/:chat_number/search/:query', to: 'chats#search_chat'
  post '/applications/:token/create_chat', to: 'chats#create'


  #Message Routing
  get '/applications/:token/chats/:chat_number/get_messages', to: 'messages#get_messages'
  post '/applications/:token/chats/:chat_number/send_message', to: 'messages#create'
  put '/applications/:token/chats/:chat_number/update_message/:message_number', to: 'messages#update'


end
