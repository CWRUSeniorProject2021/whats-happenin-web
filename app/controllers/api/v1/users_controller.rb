module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_user

      def profile
      end

      def myprofile
      end

    private

      def authorize_user
        case params[:action].to_sym
        when :profile
          @user = User.find(params[:id])
        when :myprofile
          @user = current_user
        end
        authorize @user || User
      end
    end
  end
end
