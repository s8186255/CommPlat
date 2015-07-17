json.array!(@mod_comm_apis) do |mod_comm_api|
  json.extract! mod_comm_api, :id
  json.url mod_comm_api_url(mod_comm_api, format: :json)
end
