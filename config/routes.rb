# http://apidock.com/rails/ActionDispatch/Routing/Mapper/Resources/resources

SocialDevotional::Application.routes.draw do

  # Library
  root :to => "studies#index"
  resources :studies, only: [:index, :show ], path: 'library' do
    resources :lessons, only: [:index, :show ] do
      resources :questions, only: [:index, :show, :new, :create], shallow: true do
        post :block, :star, :on => :member
        resources :answers, shallow: true do
          post :block, :star, :on => :member
        end
      end
    end
  end

  # Groups
  resources :groups do
    resources :meetings do
      resources :questions, only: [:index, :new, :create]
      # NOTE: :block, :star, :show, :answers 
      # already part of the previous shallow routes
    end
  end
  
  
  
  # Authentication & Admin
  devise_for :users, :skip => [:sessions]
  as :user do
    get     'signin' => 'devise/sessions#new',      :as => :new_user_session
    post    'signin' => 'devise/sessions#create',   :as => :user_session
    delete  'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  
  devise_for :admin_user
  namespace  :admin do
    resources :studies, :lessons
  end

end
