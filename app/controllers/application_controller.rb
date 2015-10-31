class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  
  # Note: leaving it like this here to accommodate for
  # the future non-API controllers, 
  # but overriding with "null_session" in the ApiController
  protect_from_forgery with: :exception
end
