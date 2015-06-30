# encoding: utf-8

class Role
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type:String
  field :desc, type:String

  has_many :users
  has_many :controller_permissions, dependent: :destroy

  validates :name, :desc, presence: true
  validates :name, uniqueness: true
end
