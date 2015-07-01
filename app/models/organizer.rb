# encoding: utf-8
class Organizer
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user, dependent: :destroy
  belongs_to :expo
  has_many :payments

  field :real_name
  field :phone
  field :mobile
  validates :mobile, format: { with: /\A1[3|4|5|7|8][0-9]\d{8}\z/ , message: "手机号码输入不正确" }
  field :company_name
  default_scope -> { order(created_at: :desc)}

  accepts_nested_attributes_for :user
  validates :company_name, :real_name, :mobile, :expo, :user, presence: true
end
