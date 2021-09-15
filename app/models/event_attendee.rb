class EventAttendee < ApplicationRecord
    enum rsvp_status: { maybe: 0, yes: 1 }

    belongs_to :event, optional: false
    belongs_to :user, optional: false

    validates :event, uniqueness: {scope: :user}
end