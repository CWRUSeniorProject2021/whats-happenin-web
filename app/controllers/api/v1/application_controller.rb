module Api
  module V1
    class ApplicationController < ActionController::API
      include Pundit
      include DeviseTokenAuth::Concerns::SetUserByToken
      include ActionView::Layouts
      include ActionController::ImplicitRender

      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

      before_action :authenticate_user!
      before_action :configure_permitted_parameters, if: :devise_controller?
      before_action :define_globals

      layout "application"

    protected

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name])
      end

    private

      ##
      # Override policy scope for use with namespaced controllers.
      def policy_scope(scope)
        super([:api, :v1, scope])
      end

      ##
      # Override authorize method for use with namespaced controllers.
      def authorize(record, query = nil)
        super([:api, :v1, record], query)
      end

      ##
      # Override permitted_attributes method for use with namespaced controllers.
      def permitted_attributes(record, action = params[:action])
        super([:api, :v1, record], action)
      end

      ##
      # Define instance variables that are used in render layouts
      def define_globals
        @status = true
        @errors = {}
      end

      ##
      # Use the 403 - Forbidden error code to signify denied access to a resource.
      def user_not_authorized
        render json: {}, status: :forbidden
      end
    end
  end
end
