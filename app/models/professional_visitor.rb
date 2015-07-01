# encoding: utf-8

class ProfessionalVisitor
  include Mongoid::Document
  belongs_to :user

  field :real_name, type: String
  field :english_name, type: String
  field :company_name, type: String
  field :company_addr, type: String
  field :sex, type: Integer
  field :job, type: String
  field :department, type: String
  field :mobile, type: String
  field :qq, type: String
  field :weixin, type: String
  field :website, type: String
  field :fax, type: String
  field :area, type: String
  field :phone, type: String

  validates :real_name, :company_name,  :sex, :company_addr, :job, :mobile, presence: true
end
