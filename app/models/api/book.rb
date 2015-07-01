class Api::Book
  include Mongoid::Document
  field :name, type: String
  field :author, type: String
end
