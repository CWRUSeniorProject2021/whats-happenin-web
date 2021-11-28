load_events |= false
json.id user.id
json.first_name user.first_name
json.last_name user.last_name
json.username user.username
json.school do
  json.id user.school.id
  json.name user.school.name
end
if user == current_user
  json.email user.email
end

if load_events
  json.events user.events do |e|
    json.partial! 'api/v1/events/event', locals: {event: e}
  end
end
