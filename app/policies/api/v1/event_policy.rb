module Api
  module V1
    class EventPolicy < ApiPolicy

      def index?
        false
      end

      def show?
        record.public_vis? || (user.school == record.school)
      end

      def create?
        user.present?
      end

      def new?
        create?
      end

      def update?
        user == record.user
      end

      def edit?
        update?
      end

      def destroy?
        user == record.user
      end

      def permitted_attributes
        return [:title, :description, :start_date, :end_date, :school_id, :image, :visibility]
      end
    end
  end
end
