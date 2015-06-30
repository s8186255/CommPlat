json.array!(@user_reports) do |user_report|
  json.extract! user_report, :id
  json.url user_report_url(user_report, format: :json)
end
