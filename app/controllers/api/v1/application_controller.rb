module Api
  module V1
    class ApplicationController < ActionController::API
      include DeviseTokenAuth::Concerns::SetUserByToken
      before_action :authenticate_user!
      before_action :configure_permitted_parameters, if: :devise_controller?

    protected

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name])
      end

    private

      # Override policy scope for use with namespaced controllers.
      def policy_scope(scope)
        super([:api, :v1, scope])
      end

      # Override authorize method for use with namespaced controllers.
      def authorize(record, query = nil)
        super([:api, :v1, record], query)
      end
    end
  end
end
