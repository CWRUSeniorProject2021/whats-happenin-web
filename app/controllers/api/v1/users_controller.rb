module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_user

      def profile
      end

    private

      def authorize_user
        case params[:action].to_sym
        when :profile
          @user = User.find(params[:id])
        end
        authorize @user || User
      end
    end
  end
end
