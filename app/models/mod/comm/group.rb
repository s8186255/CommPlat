class Mod::Comm::Group
  include Mongoid::Document
  field :name, type: String
  field :phones, type: Array
end
