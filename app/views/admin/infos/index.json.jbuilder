json.array!(@user_homes) do |user_home|
  json.extract! user_home, :id
  json.url user_home_url(user_home, format: :json)
end
