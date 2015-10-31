class ApiController < ApplicationController

  # Prevent CSRF attacks with null session;
  # Also see comment in ApplicationController
  protect_from_forgery with: :null_session

  # Note: Uncomment the below method definition if ActiveModels serialized as JSON
  # are needed to be flat (e.g. as normally returned by #as_json).
  # (see also http://stackoverflow.com/questions/15350859/make-root-node-in-active-model-serializer)
  # def default_serializer_options
  #   { root: false }
  # end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    # Adding "errors" key for consistency with the JSON object returned on record creation failure
    render json: { errors: 'not_found' }, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    render json: { errors: exception.record.errors }, status: :bad_request
  end

end