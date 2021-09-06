json.user do |json|
  byebug
  json.partial! 'users/user', user: current_user
end
