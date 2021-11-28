module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_user

      def update
        begin
          @user.update!(permitted_attributes(@user))
          render :action => :update
        rescue ActiveRecord::RecordInvalid
          @errors = @user.errors
          render :action => :update, status: :bad_request
        end
      end

      def profile
      end

      def myprofile
      end

    private

      def authorize_user
        case params[:action].to_sym
        when :profile, :update
          @user = User.find(params[:id])
        when :myprofile
          @user = current_user
        end
        authorize @user || User
      end
    end
  end
end
