json.extract! token, :id, :user_id, :app_id, :token, :expires_at, :created_at, :updated_at
json.url token_url(token, format: :json)
