
Rails.application.routes.draw do
mount ActionCable.server => '/cable'
 
  resource :payments, only: [:new, :create,:cancel,:index] do
    get :success, on: :collection
    get :cancel, on: :collection
    get :index ,on: :collection 
  end
  

  # resource :messages, only: [:new,:create]
  resources :messages, only: [:index, :create]

  namespace :oauth do
    namespace :google_oauth2 do
      get "callback"
    end
  end

  post "/webhooks/stripe", to: "webhooks#stripe"

  root "pages#home"
  get  "/chat", to: "pages#msgpage"
  post "/chat",to: "messages#create"
  get  "/customers_chats" ,to:"pages#chat_query_list"
  get  "pages/contact", to: "pages#contact", as: "pages_contact"
  post 'pages/contact', to: 'pages#contact_submit'
  post 'subscribe', to: 'pages#subscribe'

  get '/order' ,to: 'pages#user_booked_property'

  # Role-based login routes
  get  'login/admin',  to: 'sessions#admin_login',  as: :admin_login
  get  'login/agent',  to: 'sessions#agent_login',  as: :agent_login
  get  'login',   to: 'sessions#new',   as: :user_login
  get 'admin', to:'sessions#admin_login'
  get 'agent' ,to:'sessions#agent_login'

  post 'login/admin',  to: 'sessions#admin_create'
  post 'login/agent',  to: 'sessions#agent_create'
  post 'login',   to: 'sessions#create'
  

  # Dashboards
  get 'admin/dashboard', to: 'dashboards#admin_dashboard'
  get 'agent/dashboard', to: 'dashboards#agent_dashboard'
  get 'agent/dashboard/property-list' , to:'dashboards#agentpropertylst'
  get 'agent/dashboard/booked-property-list' , to:'dashboards#agentbookedpropertylst'
  get 'agent/dashboard/customer-list' , to:'dashboards#agentcustomerlst'
  get 'admin/dashboard/booked-properties', to: 'dashboards#booked_property_lst'


  # Agent signup
  get  'signup/agent', to: 'users#agent_new'
  post 'signup/agent', to: 'users#agent_create'

  # Admin signup (internal only)
  get  'signup/admin', to: 'users#admin_new'
  post 'signup/admin', to: 'users#admin_create'
  get 'admin/agentlist', to: 'dashboards#allusers_agents'

  
  get    'signup', to: 'users#new'
  resources :users, except: [:new]
  resources :wishlists, only: [:index], as: :your_property

  # get    'login',  to: 'sessions#new'
  # post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Properties
  resources :properties do
    resource :wishlist, only: [:create, :destroy]
  end
  


  # Booking cart (Book)
  resources :books, only: [:show, :destroy] do
    resources :booking_items, only: [:create, :destroy,:new]
  end
 


  # Book now shortcut (add property to cart)
  post "book_now/:property_id",
       to: "booking_items#create",
       as: :book_now

end
