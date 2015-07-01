class ExhibitorCardType
  include Mongoid::Document
  include Mongoid::Timestamps

  field :count, type: Integer


  belongs_to :exhibitor

  belongs_to :card_type

  validates :count, presence: true

end
