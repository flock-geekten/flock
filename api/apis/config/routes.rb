Rails.application.routes.draw do
  resources :post_tags
  resources :hangouts
  resources :comments
  resources :users
  resources :tags
  resources :posts do
    get '/summaries', to: 'summaries#show'
    post '/summaries', to: 'summaries#create'
    put '/summaries', to: 'summaries#update'
    delete '/summaries', to: 'summaries#destroy'
  end
  
  # いいね機能まわり
  post '/likes', to: 'likes#create'
  delete '/likes', to: 'likes#destroy'
  post '/is_like', to: 'likes#is_likes'

  # フォロー機能まわり
  post '/follow', to: 'relationships#follow'
  delete '/unfollow', to: 'relationships#unfollow'
  post '/is_follow', to: 'relationships#is_follow'

  namespace 'api' do
    namespace 'v1' do
      get 'posts' => 'posts_api#index'
      get 'posts/:post_id' => 'posts_api#show'
      post 'current_user' => 'users#current_user'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
