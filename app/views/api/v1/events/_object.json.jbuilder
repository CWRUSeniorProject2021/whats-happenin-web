json.event do
  json.id @event.id
  json.title @event.title
  json.description @event.description
  json.attendee_limit @event.attendee_limit
  json.start_date @event.start_date
  json.end_date @event.end_date
  json.image_url url_for(@event.image) if @event.image.attached?
end
