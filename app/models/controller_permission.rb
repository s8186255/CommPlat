class ControllerPermission
  include Mongoid::Document
  include Mongoid::Timestamps

  field :controller_name, type: String
  field :actions, type: Array
  field :desc

  belongs_to :role

  validates :controller_name, :actions, presence: true

  index({ controller_name: 1 })
end
