json.extract! room, :id, :name, :description, :price, :address, :image, :user_id, :created_at, :updated_at
json.url room_url(room, format: :json)
