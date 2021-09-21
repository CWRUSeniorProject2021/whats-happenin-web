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

      def attendees?
        show?
      end

      def nearby?
        user.present?
      end

      def permitted_attributes
        return [:title, :description, :start_date, :end_date, :school_id, :image, :visibility, :attendee_limit,
        address_attributes: [:id, :street1, :street2, :city, :state_code, :country_code, :postal_code]]
      end
    end
  end
end
