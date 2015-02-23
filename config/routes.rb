Rails.application.routes.draw do
  


  root 'static#index'

  resources :sessions, only: [:new, :create], as: :login
  get 'logout', to: 'sessions#destroy', as: :logout 

  namespace :admin do   
    get 'dashboard', to: 'dashboard#dashboard'
    post 'lock', to: 'companies#lock'
    resources :companies do 
      resources :offices, only: [:create, :edit]
    end
  end

  get 'signup/office/:office_join_token', to: 'signup#new_office'
  post 'signup/office/:office_join_token', to: 'signup#office_contact', as: :office_contact

  get 'signup/cohort/:join_token', to: 'signup#new_cohort_join', as: :cohort_join
  post 'signup/cohort/:join_token', to: 'signup#join_cohort', as: :join_cohort

  scope module: 'office' do 
    resources :users, except: [:create] do 
      collection do 
        get 'search'
      end
    end
    get 'dashboard', to: 'users#dashboard'
    resources :cohorts do 
      member do 
        post 'new_hires'
        post 'managers'
      end
    end
  end

  resources :password_resets, only: [:new, :create, :edit, :update]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
