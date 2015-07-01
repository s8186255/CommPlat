json.array!(@api_books) do |api_book|
  json.extract! api_book, :id, :name, :author
  json.url api_book_url(api_book, format: :json)
end
