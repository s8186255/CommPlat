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
    def authenticate opts={}
      if opts[:name]
        return self.find_by(name:opts[:name]).authenticate(opts[:password])
      elsif opts[:email]
        return self.find_by(email:opts[:email]).authenticate(opts[:password])
      elsif opts[:token]
        return find_by(token: opts[:token])
      else
        return nil
      end
    end
  end

  protected
  def gen_token
    self.token = SecureRandom.hex
  end
end
