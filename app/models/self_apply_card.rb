# encoding: utf-8
class SelfApplyCard
  include Mongoid::Document
  include Mongoid::Timestamps

  #info field
  field :name,type:String
  field :gender,type:String#性别

  field :phone,type:String#联系电话

  field :email,type:String#邮件


  field :job_title,type:String#职务

  field :province,type:String#省份
  field :city,type:String#城市
  field :inhabit_address,type:String#现居住地

  field :work_unit,type:String#工作单位全程

  field :id_card,type:String#身份证号

  # 电子照片
  mount_uploader :photo, Attachment::ImageUploader



  # 通用属性
  # 序号
  field :sn, type: String

  before_create :gensn

  # 卡片状态 0 未提交申请  1提交申请 2申请通过 -1申请未通过 3已经交费 4已打印
  field :status, type: Integer, default: 1

  # 审核失败消息
  field :message, type: String

  #是否审核过
  #field :is_auditor_check, type: Boolean, default: false
  #是否打印过
  #field :is_printed, type: Boolean, default: false
  #field :content, type: Hash #下一步可以优化，进行自定义；

  # scope
  # 已提交
  scope :apply, -> { where(status: 1) }
  # 已审核
  scope :checked, -> { where(status: 2) }

  #relations
  belongs_to :card_type
  belongs_to :expo

  #validates
  # 自动生成验证
  validates :card_type, :expo, presence: true

  # 共用验证
  validates :name, :phone, :photo, presence: true
  validates :phone, format: { with: /\A1[3|4|5|7|8][0-9]\d{8}\z/ , message: "手机号码输入不正确" }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,  message: "邮箱格式不正确" }, allow_nil: true, allow_blank: true

  # 境内人员验证
  #{ name: 'name', title: '姓名', type: 'String' },
  #{ name: 'gender', title: '性别', type: 'String'},
  #{ name: 'id_card', title: '身份证号码', type: 'String', desc: "注意：身份证号码如有字母，请填写小写字母x"},
  #{ name: 'work_unit', title: '工作单位', type: 'String'},
  #{ name: 'job_title', title: '职务', type: 'String'},
  #{ name: 'province', title: '省份', type: 'String'},
  #{ name: 'city', title: '城市', type: 'String'},
  #{ name: 'inhabit_address', title: '现居地址', type: 'String'},
  #{ name: 'email', title: 'Email', type: 'String'},
  #{ name: 'phone', title: '手机号码', type: 'String'},
  #{ name: 'photo', title: '电子照片', type: 'File', desc: "上传要求:须近期免冠彩色白底JPG格式电子照片，照片横竖比例为3:4，文件大小20-30KB" } ]

  validates :gender, :id_card, :work_unit, :province, :city, :inhabit_address, presence: true
  validates :id_card, format: { with: /\A\d{17}[x|X|0-9]\z/ , message: "身份证格式不正确" }

  def gensn
    last_card = SelfApplyCard.last
    if last_card and last_card.sn
      self.sn = last_card.sn.next
    else
      self.sn = "0000001"
    end
  end

end
