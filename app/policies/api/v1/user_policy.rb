module Api
  module V1
    class UserPolicy < ApiPolicy

      def index?
        false
      end

      def show?
        false
      end

      def create?
        false
      end

      def new?
        create?
      end

      def update?
        record == user
      end

      def edit?
        update?
      end

      def destroy?
        false
      end

      def profile?
        user.present?
      end

      def myprofile?
        user.present?
      end

      def permitted_attributes
        return [:first_name, :last_name, :username, :email]
      end
    end
  end
end
