Rails.application.routes.draw do
  resources :jobs
  resources :clients
  resources :users
  resources :contact_informations
  resources :addresses
  resources :bookings, only: [:index, :create, :destroy]
  resources :service_types, only: [:index]
  resources :availables, only: [:update, :destroy]

  post "/signup", to: "users#signup"
  post "/login", to: "users#login"

  #Check in and out of jobs
  post "/jobs/:id/checkin", to: "jobs#job_check_in"
  post "/jobs/:id/checkout", to: "jobs#job_check_out"
  # Assign Employees
  post "/jobs/:id/assignuser", to: "jobs#job_assign_user"
  # Post new Available
  post "/users/:id/available", to: "availables#create"
  get "/users/:id/available", to: "availables#show"
  # Add notes to jobs
  post "/jobs/:id/notes", to: "jobs#create_notes"
end
