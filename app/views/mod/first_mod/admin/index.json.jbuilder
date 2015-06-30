json.array!(@mod_first_mod_admins) do |mod_first_mod_admin|
  json.extract! mod_first_mod_admin, :id
  json.url mod_first_mod_admin_url(mod_first_mod_admin, format: :json)
end
