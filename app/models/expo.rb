class Expo
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :desc, type: String
  field :alive, type: Boolean, default: false #是否可用；

  scope :active, -> { where(alive: true)}
  default_scope -> { order(created_at: :desc)}

  def alived?
    alive == true
  end

  #relations
  #belongs_to
  has_one :organizer
  #belongs_to :user
  #has_many
  has_many :cards
  has_many :self_apply_cards

  has_many :exhibitors

  has_many :payments
  #has_and_belongs_to_many
  has_and_belongs_to_many :card_types

  #config nested attributes
  accepts_nested_attributes_for :card_types

  validates :name, :desc,  presence: true

end
