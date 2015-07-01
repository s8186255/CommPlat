json.array!(@user_ceshis) do |user_ceshi|
  json.extract! user_ceshi, :id, :name
  json.url user_ceshi_url(user_ceshi, format: :json)
end
