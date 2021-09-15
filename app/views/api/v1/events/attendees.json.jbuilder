json.attendees @event.event_attendees do |ea|
    user = ea.user
    json.rsvp_status ea.rsvp_status
    json.first_name user.first_name
    json.last_name user.last_name
    json.user_id ea.user_id
end