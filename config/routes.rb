SocialDevotional::Application.routes.draw do

  # Library
  root :to => "series#index"
  resources :series, only: [:index, :show ], path: 'library' do
    resources :lessons, only: [:index, :show ] do
      resources :questions, only: [:index, :show, :new, :create] do
        member do
          post :block 
          post :star
        end
      end
    end
  end

  # Groups
  resources :groups do
    resources :meetings do
      resources :questions, only: [:index, :show, :new, :create] do
        member do
          post :block 
          post :star
        end
      end
    end
  end

  # Authentication & Admin
  devise_for :users
  devise_for :admins
  namespace :admin do
    resources :groups
    resources :lessons
    resources :questions
    resources :series
  end

  # http://apidock.com/rails/ActionDispatch/Routing/Mapper/Resources/resources
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
