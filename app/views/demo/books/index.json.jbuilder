json.array!(@demo_books) do |demo_book|
  json.extract! demo_book, :id, :name, :author, :pagecount
  json.url demo_book_url(demo_book, format: :json)
end
