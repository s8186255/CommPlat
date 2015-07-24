class Mod::Comm::Phone
  include Mongoid::Document
  field :number, type: String
  field :name, type: String
end
