json.array!(@admin_homes) do |admin_home|
  json.extract! admin_home, :id
  json.url admin_home_url(admin_home, format: :json)
end
