Rails.application.routes.draw do
  resources :comments
  resources :users
  resources :post_tags
  resources :tags
  resources :posts do
    get '/summaries', to: 'summaries#show'
    post '/summaries', to: 'summaries#create'
    put '/summaries', to: 'summaries#update'
    delete '/summaries', to: 'summaries#destroy'
  end

  namespace 'api' do
    namespace 'v1' do
      get 'posts' => 'posts_api#index'
      get 'posts/:post_id' => 'posts_api#show'
      post 'current_user' => 'users#current_user'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
