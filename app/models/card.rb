# encoding: utf-8
class Card
  include Mongoid::Document
  include Mongoid::Timestamps

  #info field
  field :name,type:String
  field :en_name,type:String #英文名
  field :birth,type:Date#生日
  field :gender,type:String#性别

  field :phone,type:String#联系电话

  field :email,type:String#邮件


  field :job_title,type:String#职务

  field :country,type:String#国家
  field :area,type:String#国家/地区
  field :province,type:String#省份
  field :city,type:String#城市
  field :inhabit_address,type:String#现居住地

  field :work_unit_abbr,type:String#工作单位简称
  field :work_unit,type:String#工作单位全程
  field :work_branch,type:String#工作所属部门

  field :id_card,type:String#身份证号
  field :other_card,type:String#证件号码

  field :id_type,type:String#证件类型
  field :id_card_expiry_date,type:Date#身份证到期日
  field :passport,type:String#护照
  field :passport_expiry_date,type:Date#护照到期日

  field :booth_no,type:String#展位编号

  field :vehicle_type,type:String#车辆类型
  field :vehicle_no,type:String#车牌号
  # 电子照片
  mount_uploader :photo, Attachment::ImageUploader



  # 通用属性
  # 序号
  field :sn, type: String

  before_create :gensn

  # 卡片状态 0 未提交申请  1提交申请 2申请通过 -1申请未通过 3已经交费 4已打印
  field :status, type: Integer, default: 0

  # 卡片所属类型 境内、境外、车证
  #
  field :type, type: Integer

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
  # 已缴费
  scope :cashed, -> { where(status: 3) }

  #relations
  belongs_to :card_type
  belongs_to :expo
  belongs_to :exhibitor
  belongs_to :payment

  #validates
  # 自动生成验证
  validates :card_type, :expo, :exhibitor, presence: true

  # 共用验证
  validates :name, :phone, :photo, presence: true, on: :update
  validates :phone, format: { with: /\A1[3|4|5|7|8][0-9]\d{8}\z/ , message: "手机号码输入不正确" },  on: :update
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,  message: "邮箱格式不正确" }, allow_nil: true, allow_blank: true, on: :update

  # 车证验证
  #{ name: 'vehicle_no', title: '车牌号码', type: 'String' },
  #{ name: 'name', title: '驾驶员姓名', type: 'String' },
  #{ name: 'id_card', title: '身份证号', type: 'String' },
  #{ name: 'phone', title: '联系方式(手机)', type: 'String' },
  #{ name: 'work_unit', title: '车辆所属单位', type: 'String' },
  #{ name: 'booth_no', title: '展位号', type: 'String' },
  #{ name: 'photo', title: '电子照片', type: 'File', desc: "上传要求:须近期免冠彩色白底JPG格式电子照片，照片横竖比例为3:4，文件大小20-30KB" } ]
  validates :vehicle_no, :id_card, :work_unit, :booth_no, presence: true, on: :update, if: :vehicle?
  validates :id_card, format: { with: /\A\d{17}[x|X|0-9]\z/ , message: "身份证格式不正确" }, on: :update, if: :resident?
  validates :vehicle_no, length: { in: 7..10 }, on: :update, if: :vehicle?
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

  validates :gender, :id_card, :work_unit, :province, :city, :inhabit_address, presence: true,on: :update, if: :resident?
  validates :id_card, format: { with: /\A\d{17}[x|X|0-9]\z/ , message: "身份证格式不正确" }, on: :update, if: :resident?

  # 境外人员验证
  #{ name: 'name', title: '证件显示姓名', type: 'String'},
  #{ name: 'en_name', title: '英文姓名', type: 'String'},
  #{ name: 'birth', title: '出生年月日', type: 'Date'},
  #{ name: 'gender', title: '性别', type: 'String'},
  #{ name: 'id_type', title: '身份证类型', type: 'String'},
  #{ name: 'other_card', title: '证件号码', type: 'String'},
  #{ name: 'id_card_expiry_date', title: '身份证件有效期', type: 'Date'},
  #{ name: 'work_unit', title: '工作单位/服务机构', type: 'String'},
  #{ name: 'job_title', title: '职务', type: 'String', rq: "false"},
  #{ name: 'area', title: '国家地区', type: 'String'},
  #{ name: 'email', title: 'Email', type: 'String', rq: "false"},
  #{ name: 'phone', title: '手机号码', type: 'String' },
  #{ name: 'photo', title: '电子照片', type: 'File', desc: "上传要求:须近期免冠彩色白底JPG格式电子照片，照片横竖比例为3:4，文件大小20-30KB" } ]
  validates :en_name, :birth, :gender, :id_type, :other_card, :id_card_expiry_date, :work_unit, :area, presence: true, on: :update, if: :foreigner?

  def vehicle?
    card_type.applicant_type == 'vehicle'
  end

  def resident?
    card_type.applicant_type == 'resident'
  end

  def foreigner?
    card_type.applicant_type == 'foreigner'
  end

  def cashed?
    status == 3
  end

  def printed?
    status == 4
  end

  def checked?
    status == 2
  end

  def applied?
    status != 0
  end

  def gensn
    expo = self.expo
    last_card = self.card_type.cards.where(expo_id: expo.id).last
    if last_card and last_card.sn
      self.sn = last_card.sn.next
    else
      self.sn = "00001"
    end
  end

end
