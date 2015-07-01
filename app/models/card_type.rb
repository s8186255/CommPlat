# encoding: utf-8
#卡的类型
class CardType
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :sn, type: String

  field :price, type: Integer
  field :format, type: Hash
  field :applicant_type, type: String

  default_scope -> { order(created_at: :desc) }

  #relations
  #belongs_to

  #has_many
  has_many :cards
  # 专业观众卡
  has_many :self_apply_cards


  #has_one
  has_one :image, class_name: "Attachment::Image" #背景图
  #has_and_belongs_to_many
  has_and_belongs_to_many :expos

  has_many :exhibitor_card_types, class_name: "ExhibitorCardType"
  def exhibitors
    Exhibitor.in(id: exhibitor_card_types.pluck(:exhibitor_id))
  end

  #config nested property
  #accepts_nested_attributes_for :image


  #validates :name, :image, :price, presence: true
  class << self
    def type_one fields=[] #fields是一个数组，就几类值，all_fields
      generate_card fields_of(fields)
    end

    def fields_of fields=[] #fields是一个数组，包括，all_fields,vehicle,resident,foreigner,在settings.yml中定义
      card_fields = []
      fields.each{|x| card_fields.push x[:name]}
      return card_fields
    end

    #所有字段
    def all_fields
      [{name: 'name', title: '姓名', type: 'String'},
       {name: 'en_name', title: '英文名称', type: 'String'},
       {name: 'birth', title: '出生日期', type: 'String'},
       {name: 'gender', title: '性别', type: 'String'},
       {name: 'phone', title: '移动电话', type: 'String'},
       {name: 'email', title: '邮件', type: 'String'},
       {name: 'job_title', title: '职务', type: 'String'},
       {name: 'country', title: '国家', type: 'String'},
       {name: 'province', title: '省份', type: 'String'},
       {name: 'city', title: '城市', type: 'String'},
       {name: 'inhabit_address', title: '现居地址', type: 'String'},
       {name: 'work_unit_abbr', title: '工作单位简称', type: 'String'},
       {name: 'work_unit', title: '工作单位全称', type: 'String'},
       {name: 'work_branch', title: '工作部门', type: 'String'},
       {name: 'id_card', title: '身份证号', type: 'String'},
       {name: 'id_card_expiry_date', title: '身份证号过期时间', type: 'String'},
       {name: 'passport', title: '护照', type: 'String'},
       {name: 'passport_expiry_date', title: '护照过期时间', type: 'String'},
       {name: 'booth_no', title: '展位号', type: 'String'},
       {name: 'vehicle_type', title: '车辆类型', type: 'String'},
       {name: 'vehicle_no', title: '车牌号码', type: 'String'},
       {name: 'type', title: '证卡类型', type: 'String'},
       {name: 'photo', title: '照片', type: 'File'}
      ]
    end

    #车证所需字段
    def vehicle
      [{name: 'name', title: '姓名', type: 'String'},
       {name: 'en_name', title: '英文名称', type: 'String'},
       {name: 'birth', title: '出生日期', type: 'String'},
       {name: 'gender', title: '性别', type: 'String'},
       {name: 'phone', title: '移动电话', type: 'String'},
       {name: 'email', title: '邮件', type: 'String'},
       {name: 'job_title', title: '职务', type: 'String'},
       {name: 'country', title: '国家', type: 'String'},
       {name: 'province', title: '省份', type: 'String'},
       {name: 'city', title: '城市', type: 'String'},
       {name: 'inhabit_address', title: '现居地址', type: 'String'},
       {name: 'work_unit_abbr', title: '工作单位简称', type: 'String'},
       {name: 'work_unit', title: '工作单位全称', type: 'String'},
       {name: 'work_branch', title: '工作部门', type: 'String'},
       {name: 'id_card', title: '身份证号', type: 'String'},
       {name: 'id_card_expiry_date', title: '身份证号过期时间', type: 'String'},
       {name: 'passport', title: '护照', type: 'String'},
       {name: 'passport_expiry_date', title: '护照过期时间', type: 'String'},
       {name: 'booth_no', title: '展位号', type: 'String'},
       {name: 'vehicle_type', title: '车辆类型', type: 'String'},
       {name: 'vehicle_no', title: '车牌号码', type: 'String'},
       {name: 'type', title: '证卡类型', type: 'String'},
       {name: 'photo', title: '照片', type: 'File'}
      ]
    end

    #本国居民所需字段
    def resident
      [{name: 'name', title: '姓名', type: 'String'},
       {name: 'en_name', title: '英文名称', type: 'String'},
       {name: 'birth', title: '出生日期', type: 'String'},
       {name: 'gender', title: '性别', type: 'String'},
       {name: 'phone', title: '移动电话', type: 'String'},
       {name: 'email', title: '邮件', type: 'String'},
       {name: 'job_title', title: '职务', type: 'String'},
       {name: 'country', title: '国家', type: 'String'},
       {name: 'province', title: '省份', type: 'String'},
       {name: 'city', title: '城市', type: 'String'},
       {name: 'inhabit_address', title: '现居地址', type: 'String'},
       {name: 'work_unit_abbr', title: '工作单位简称', type: 'String'},
       {name: 'work_unit', title: '工作单位全称', type: 'String'},
       {name: 'work_branch', title: '工作部门', type: 'String'},
       {name: 'id_card', title: '身份证号', type: 'String'},
       {name: 'id_card_expiry_date', title: '身份证号过期时间', type: 'String'},
       {name: 'passport', title: '护照', type: 'String'},
       {name: 'passport_expiry_date', title: '护照过期时间', type: 'String'},
       {name: 'booth_no', title: '展位号', type: 'String'},
       {name: 'vehicle_type', title: '车辆类型', type: 'String'},
       {name: 'vehicle_no', title: '车牌号码', type: 'String'},
       {name: 'type', title: '证卡类型', type: 'String'},
       {name: 'photo', title: '照片', type: 'File'}
      ]

    end

    #外国人所需字段
    def foreigner
      [{name: 'name', title: '姓名', type: 'String'},
       {name: 'en_name', title: '英文名称', type: 'String'},
       {name: 'birth', title: '出生日期', type: 'String'},
       {name: 'gender', title: '性别', type: 'String'},
       {name: 'phone', title: '移动电话', type: 'String'},
       {name: 'email', title: '邮件', type: 'String'},
       {name: 'job_title', title: '职务', type: 'String'},
       {name: 'country', title: '国家', type: 'String'},
       {name: 'province', title: '省份', type: 'String'},
       {name: 'city', title: '城市', type: 'String'},
       {name: 'inhabit_address', title: '现居地址', type: 'String'},
       {name: 'work_unit_abbr', title: '工作单位简称', type: 'String'},
       {name: 'work_unit', title: '工作单位全称', type: 'String'},
       {name: 'work_branch', title: '工作部门', type: 'String'},
       {name: 'id_card', title: '身份证号', type: 'String'},
       {name: 'id_card_expiry_date', title: '身份证号过期时间', type: 'String'},
       {name: 'passport', title: '护照', type: 'String'},
       {name: 'passport_expiry_date', title: '护照过期时间', type: 'String'},
       {name: 'booth_no', title: '展位号', type: 'String'},
       {name: 'vehicle_type', title: '车辆类型', type: 'String'},
       {name: 'vehicle_no', title: '车牌号码', type: 'String'},
       {name: 'type', title: '证卡类型', type: 'String'},
       {name: 'photo', title: '照片', type: 'File'}
      ]

    end

    private
    def generate_card card_fields=[]
      card_format = {"card" => {"width" => "600px", "height" => "650px"},
                     "avatar" => {"width" => "60px", "height" => "60px", "left" => "250px", "top" => "50px"}
      }
      initial_top_location = 50
      card_fields.each do |x|
        card_format["#{x}"] ={"left" => "50px", "top" => "#{initial_top_location+=40}px", "font-size" => "20px", "font-family" => "SimSun"}
      end
      return card_format
    end
  end
end
