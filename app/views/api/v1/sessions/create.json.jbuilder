json.user do |json|
  byebug
  json.partial! 'api/v1/users/user', user: current_user
end
