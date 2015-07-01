json.array! @expos do |e|
  num =e.exhibitors.where(status: 0).size
  if num > 0
    json.id e.id.to_s
    json.name e.name
    json.num num
  end
end
