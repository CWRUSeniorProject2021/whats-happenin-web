json.user do
    json.partial! 'api/v1/users/user', locals: {user: @user}
end