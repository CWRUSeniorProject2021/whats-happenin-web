module Api
  module V1
    class ApiController < ActionController::Base
      skip_before_action :verify_authenticity_token

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
