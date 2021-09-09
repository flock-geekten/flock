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
      get 'tags/:tag_id/posts' => 'tags_api#index'
      # あそびを選択したときまわり
      post '/score', to: 'scores_api#create'
      put '/score', to: 'scores_api#update'
      delete '/score', to: 'scores_api#destroy'
      # 学習結果まわり
      post '/result', to: 'results_api#create'
      put '/result', to: 'results_api#update'
      delete '/result', to: 'results_api#destroy'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
