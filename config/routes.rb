# http://apidock.com/rails/ActionDispatch/Routing/Mapper/Resources/resources

SocialDevotional::Application.routes.draw do

  # Library
  root :to => "series#index"
  resources :series, only: [:index, :show ], path: 'library' do
    resources :lessons, only: [:index, :show ] do
      resources :questions, only: [:index, :show, :new, :create] do
        post :block, :star, :on => :member
      end
    end
  end

  # Groups
  resources :groups do
    resources :meetings do
      resources :questions, only: [:index, :show, :new, :create] do
        post :block, :star, :on => :member
      end
    end
  end

  # Authentication & Admin
  devise_for :users, :admin_user
  namespace :admin do
    resources :series, :lessons, :questions, :groups
  end

end
