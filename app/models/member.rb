# encoding: utf-8

class Member
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  #password
  field :password_digest, type: String

  has_secure_password


  ## Database authenticatable
  field :name, type: String, default: ""
  field :phone, type: String, default: ""
  field :email, type: String, default: ""
  field :token, type: String


  # ## Recoverable
  # field :reset_password_token, type: String
  # field :reset_password_sent_at, type: Time
  #
  # ## Rememberable
  # field :remember_created_at, type: Time
  #
  # ## Trackable
  # field :sign_in_count, type: Integer, default: 0
  # field :current_sign_in_at, type: Time
  # field :last_sign_in_at, type: Time
  # field :current_sign_in_ip, type: String
  # field :last_sign_in_ip, type: String
  #
  # ## Confirmable
  # #field :confirmation_token,   type: String
  # #field :confirmed_at,         type: Time
  # #field :confirmation_sent_at, type: Time
  # #field :unconfirmed_email,    type: String # Only if using reconfirmable
  #
  # ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token, type: String # Only if unlock strategy is :email or :both
  # field :locked_at, type: Time

  before_save :gen_token

  class<< self
    #此类方法的使用，综合多种验证方式；
    # 用户名+密码，name,password
    # 邮件+密码，email,password
    # 电话号码+密码,phone,password
    # token
    # params 是一个hash，{name: name,password:password},可以自动判断是什么方式；
    # 示例如下：
    # Member.authenticate ｛name: 'xj',password:'xj001'｝,会自动按照用户名+密码的验证方式；
    def authenticate opts={}
      if opts[:name]
        member = self.find_by(name: opts[:name])
        member.nil? ? false : member.authenticate(opts[:password])
      elsif opts[:email]
        member = self.find_by(email: opts[:email])
        member.nil? ? false : member.authenticate(opts[:password])
      elsif opts[:phone]
        member = self.find_by(phone: opts[:phone])
        if member.nil?
          false
        else
          member.authenticate(opts[:password])
        end
      elsif opts[:token]
        member = find_by(token: opts[:token])
        member.nil? ? false : member
      else
        return false
      end
    end
  end

  protected
  def gen_token
    self.token = SecureRandom.hex
  end
end
