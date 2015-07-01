# encoding: utf-8
class Exhibitor#参展商
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user, dependent: :destroy
  belongs_to :expo
  has_many :cards, dependent: :destroy
  field :real_name
  field :phone
  field :mobile
  field :company_name
  #field :is_auditor_check, type: Boolean #是否审核过；
  field :status, type: Integer, default: 0 #状态 0 未审核, 1财务审核通过 2审核通过、 -1审核未通过
  field :error_msg, type: String # 审核失败原因
  scope :apply, -> { where(status: 1) }

  def checked?
    status == 1
  end
  def total_price
    total_price = 0
    self.cards.each do |card|
      total_price += card.card_type.price
    end
    total_price
  end

  has_many :exhibitor_card_types, class_name: "ExhibitorCardType"
  def card_types
    CardType.in(id: exhibitor_card_types.pluck(:card_type_id))
  end
  accepts_nested_attributes_for :user
  validates :company_name, :real_name, :mobile, presence: true
end
