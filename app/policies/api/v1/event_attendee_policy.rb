module Api
    module V1
      class EventAttendeePolicy < ApiPolicy

        def permitted_attributes
          return [:rsvp_status]
        end
      end
    end
  end
  