json.extract! account, :id, :type, :balance, :currency, :user_id, :created_at, :updated_at
json.url account_url(account, format: :json)
