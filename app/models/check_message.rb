class CheckMessage
  include Mongoid::Document

  #field
  field :name,type: String
  field :sn,type: String
  field :name,type: String
  field :name,type: String
  field :name,type: String
  field :name,type: String

  #relations
  #belongs_to
  belongs_to :card_type
  belongs_to :expo
  belongs_to :exhibitor
  belongs_to :organizer

  #has_many

  #has_one
  #has_one :avatar, class: "Attachment::Image"


  validates :phone, :real_name, :mobile, :scopes, presence: true
end
