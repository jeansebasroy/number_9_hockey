Rails.application.routes.draw do
  root 'static_pages#home'

# => for Users
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :invitations
  resources :password_resets
  match '/home',      to: 'users#home',             via: 'get'
  match '/signup',    to: 'users#new',              via: 'get'
  match '/signin',    to: 'sessions#new',           via: 'get'
  match '/signout',   to: 'sessions#destroy',       via: 'delete'
  
# => for Players
  resources :players do
    resources :player_evaluations
  end
  
# for Camps
  resources :camps do
    resources :date_time_locations
  end
  match '/camps/publish',     to: 'camps#publish',    via: 'post'
  match '/camps/unpublish',   to: 'camps#unpublish',  via: 'post'
  
# => links Players to Camps  
  match '/payments/payment',   to: 'payments#payment',   as: 'paymentspayment',    via: 'get'
  match '/payments/thank_you', to: 'payments#thank_you', as: 'payments_thank_you', via: 'get'
  match '/player_unregister',  to: 'player_camp_registrations#un_register',        via: 'post'
  resources :player_camp_registrations

# => for requesting information
  resources :info_requests
  resources :scouting_requests
  resources :support_requests
  
  match '/why_9',     to: 'static_pages#why_9',     via: 'get'
  match '/about_us',  to: 'static_pages#about_us',  via: 'get'
  
  match '/privacy_policy',          to: 'static_pages#privacy_policy',          via: 'get'
  match '/refund_policy',           to: 'static_pages#refund_policy',           via: 'get'
  match '/player_camp_agreement',   to: 'static_pages#player_camp_agreement',   via: 'get'


  #misc redirects
  match '/invitation/verify', to: 'invitations#verify_user_invitation', via: 'post'
  match '/players/invite',    to: 'players#player_invite',              via: 'post'
  
  #match '/admin_home',        to: 'users#admin_home',                   via: 'get'

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
