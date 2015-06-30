# encoding: utf-8

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  default_scope -> { order(updated_at: :desc) }
  scope :filter_type, ->(user_type) { where(type: user_type) }

  #扩展user
  include UserExt
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
    :rememberable, :trackable, :validatable, :lockable, :recoverable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  #field :confirmation_token,   type: String
  #field :confirmed_at,         type: Time
  #field :confirmation_sent_at, type: Time
  #field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  field :locked_at,       type: Time

end
