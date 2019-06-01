json.extract! inquiry, :id, :inquiry_at, :inquiry_cd, :inquiry_content, :accept_cd, :error_json, :created_at, :updated_at
json.url inquiry_url(inquiry, format: :json)
