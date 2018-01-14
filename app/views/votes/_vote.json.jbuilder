json.extract! vote, :id, :user_id, :place_id, :rank, :created_at, :updated_at
json.url vote_url(vote, format: :json)
