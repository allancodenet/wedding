json.extract! client, :id, :name, :wedding_date, :location, :guest_no, :budget, :created_at, :updated_at
json.url client_url(client, format: :json)
