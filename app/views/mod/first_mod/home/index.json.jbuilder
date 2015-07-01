json.array!(@mod_first_mod_homes) do |mod_first_mod_home|
  json.extract! mod_first_mod_home, :id
  json.url mod_first_mod_home_url(mod_first_mod_home, format: :json)
end
