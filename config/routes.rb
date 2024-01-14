Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "homes#top"
  get "home/about",to: "homes#about"
  devise_for :users

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
  
    resource :favorite, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
    
  end
  
  # フォロー/フォロワー機能の実装 %>
  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
  	get "followings" => "relationships#followings", as: "followings"
  	get "followers" => "relationships#followers", as: "followers"
  end
  #ここまで
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
