json.array!(@home_homes) do |home_home|
  json.extract! home_home, :id
  json.url home_home_url(home_home, format: :json)
end
