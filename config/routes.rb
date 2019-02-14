Rails.application.routes.draw do
  get 'canteens/index'
  get 'canteens/show'
  get 'canteens/create'
  get 'users/index'
  
  get 'canteens/:canteen_id/users', to: 'users#index1', as: 'canteen_admins'
  #devise_for :users
  devise_for :users
  devise_scope :user do 
    match "/canteens/:canteen_id/invitations/new", :to => "users/invitations#new", :via => "get", :as => "new_canteen_invitation"
    #match "/canteens/:canteen_id/invitations/create", :to => "users/invitations#create", :via => "post", :as => "create_canteen_invitation"
  end
  root 'users#index'

  resources :canteens do
    resources :users
    resources :customers do
      resources :attendance_details
      resource :membership do
        resources :payments
      end
  	end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
