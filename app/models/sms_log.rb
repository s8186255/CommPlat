class SmsLog
  include Mongoid::Document
  include Mongoid::Timestamps
  field :mobile, type: String
  field :text, type: String
  default_scope -> { order(created_at: :desc)}

  validates :mobile, :text,  presence: true

end
