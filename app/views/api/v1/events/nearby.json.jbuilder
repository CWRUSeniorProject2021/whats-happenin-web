json.events @events do |e|
    json.partial! 'api/v1/events/object', locals: {event: e}
end