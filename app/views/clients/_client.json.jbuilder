json.extract! client, :id, :title, :desc, :email, :phone, :url, :site, :send_hello, :created_at, :updated_at
json.url client_url(client, format: :json)
