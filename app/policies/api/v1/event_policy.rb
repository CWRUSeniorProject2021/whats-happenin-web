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

      def nearby?
        user.present?
      end

      def rsvp?
        user.present?
      end

      def attendees?
        user == record.user
      end

      def mine?
        user.present?
      end

      def upcoming?
        user.present?
      end

      def past?
        user.present?
      end

      def permitted_attributes
        return [:title, :description, :start_date, :end_date, :school_id, :image, :image_64, :visibility, :attendee_limit, :restricted, :rsvp_status,
        address_attributes: [:id, :street1, :street2, :city, :state_code, :country_code, :postal_code]]
      end
    end
  end
end
