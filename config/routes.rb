Rails.application.routes.draw do

  root "pages#home"
  get  "pages/contact", to: "pages#contact", as: "pages_contact"
  post 'pages/contact', to: 'pages#contact_submit'
  post 'subscribe', to: 'pages#subscribe'

  # Authentication
  get    'signup', to: 'users#new'
  resources :users, except: [:new,:index]
  resources :wishlists, only: [:index], as: :your_property

  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Properties
  resources :properties do
    resource :wishlist, only: [:create, :destroy]
  end
  

  

  # Booking cart (Book)
  resources :books, only: [:show, :destroy] do
    resources :booking_items, only: [:create, :destroy]
  end

  # Book now shortcut (add property to cart)
  post "book_now/:property_id",
       to: "booking_items#create",
       as: :book_now

end
