json.groups(@groups) do |group|
  #json.extract! group, :name,:phones
  json.name group.name
  json.phones group.phones
end
