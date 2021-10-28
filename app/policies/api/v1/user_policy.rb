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
        false
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

      def permitted_attributes
        return []
      end
    end
  end
end
