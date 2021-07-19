Rails.application.routes.draw do
  resources :jobs
  resources :clients
  resources :users
  resources :contact_informations
  resources :addresses
  resources :bookings, only: [:index, :create, :destroy]
  resources :service_types, only: [:index]

  post "/signup", to: "users#signup"
  post "/login", to: "users#login"

  #Check in and out of jobs
  post "/jobs/:id/checkin", to: "jobs#job_check_in"
  post "/jobs/:id/checkout", to: "jobs#job_check_out"
  post "/jobs/:id/assignuser", to: "jobs#job_assign_user"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
