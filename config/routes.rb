Rails.application.routes.draw do
  resources :loans, defaults: {format: :json} do 
    resources :payments, only: [:create, :index]
  end
  # Payments resource is duplicated here for the purpose of making
  # the API more concise: if an individual payment is requested, 
  # using a path like /loans/:loan_id/payments/:payment_id would
  # be redundant since :payment_id already uniquely identifies
  # a payment resource;
  # It is a matter of opinion whether to do it this way or not; 
  # I feel that it makes things more user-friendly and nice overall
  resources :payments, only: :show
end
