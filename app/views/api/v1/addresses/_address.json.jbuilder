json.address do
  json.street1 address.street1
  json.street2 address.street2
  json.city address.city
  json.state do
    json.name address.state_name
    json.code address.state_code
  end
  json.country do
    json.name address.country_name
    json.code address.country_code
  end
  json.postal_code address.postal_code
  json.coordinates do
    json.latitude address.latitude
    json.longitude address.longitude
  end
end
