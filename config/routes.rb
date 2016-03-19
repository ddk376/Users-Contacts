Rails.application.routes.draw do

  resources :contacts, only: [:create, :destroy, :show, :update] do
    resources :comments do
      member do
        get 'favorite'
      end
    end
  end

  resources :contact_shares, only: [:create, :destroy]

  resources :users, only: [:create, :destroy, :index, :show, :update] do
    resources :contacts, only: [:index] do
      collection do
        get 'favorite'
      end
    end
    resources :comments
  end

# Manual 8 magic routes, matches on HTTP method and URL path...
# get 'users' => 'users#index', :as => 'users'
# post 'users' => 'users#create'
# get 'users/new' => 'users#new', :as => 'new_user'
# get 'users/:id/edit' => 'users#edit', :as => 'edit_user'
# get 'users/:id' => 'users#show', :as => 'user'
# patch 'users/:id' => 'users#update'
# put 'users/:id' => 'users#update'
# delete 'users/:id' => 'users#destroy'

end
