class Payment
  include Mongoid::Document
  include Mongoid::Timestamps

  #field
  # 订单金额
  field :value, type: Integer
  # 订单号
  field :sn, type: String
  # 财务检查过否
  field :is_accountant_check, type: Boolean, default: false

  #relations
  has_many :cards
  #belongs_to
  belongs_to :expo
  # 主办方创建
  belongs_to :organizer
  # 财务人员
  belongs_to :accountant, class_name: 'User'

  validates :sn, :value, presence: true
  validates :sn, uniqueness: true
  #
  # callback
  before_save :generate_order_sn

  private
  def generate_order_sn
    length = 6
    self.sn = Time.now.strftime("%Y%m%d%H%M%S") + rand.to_s[2..length]
    #如果验证不通过且是sn出错则重新生成sn
    generate_order_sn unless self.valid? or self.errors[:sn].blank?
  end
end
