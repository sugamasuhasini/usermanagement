json.extract! user, :id, :username, :shell_type, :home_folder, :password, :grant_sudo, :created_at, :updated_at
json.url user_url(user, format: :json)
