json.extract! quest, :id, :user_id, :quest, :visited_place, :visited_plate, :lat, :lng, :created_at, :updated_at
json.url quest_url(quest, format: :json)
