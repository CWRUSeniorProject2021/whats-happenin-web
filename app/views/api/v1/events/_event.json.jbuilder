json.id event.id
json.title event.title
json.description event.description
json.attendee_limit event.attendee_limit
json.start_date event.start_date
json.end_date event.end_date
json.image_url polymorphic_url(event.image) if event.image.attached?
json.restricted event.restricted
json.partial! 'api/v1/addresses/address', locals: {address: event.address}
json.comments event.comments do |c|
  json.partial! 'api/v1/comments/comment', locals: {comment: c}
end
