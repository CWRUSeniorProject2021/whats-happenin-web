json.(user, :id, :email, :username, :first_name, :last_name)
json.token user.generate_jwt
