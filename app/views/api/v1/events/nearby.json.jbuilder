json.events @events do |e|
    json.partial! 'api/v1/events/event', locals: {event: e}
end