json.array!(@mod_first_mod_users) do |mod_first_mod_user|
  json.extract! mod_first_mod_user, :id
  json.url mod_first_mod_user_url(mod_first_mod_user, format: :json)
end
