json.extract! poll, :id, :title, :body, :start, :finish, :status, :poll_type, :user_id, :created_at, :updated_at
json.url poll_url(poll, format: :json)