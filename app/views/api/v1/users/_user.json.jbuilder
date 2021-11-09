if user == current_user
    json.id user.id
    json.first_name user.first_name
    json.last_name user.last_name
    json.username user.username
    json.email user.email
else
    json.id user.id
    json.first_name user.first_name
    json.last_name user.last_name
    json.events user.events do |e|
        json.partial! 'api/v1/events/event', locals: {event: e}
    end
end