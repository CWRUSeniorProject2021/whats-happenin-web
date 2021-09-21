json.event do
    json.partial! 'api/v1/events/event', locals: {event: @event}
end