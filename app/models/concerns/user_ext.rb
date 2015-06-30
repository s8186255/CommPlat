# encoding: utf-8

module UserExt
  extend ActiveSupport::Concern
  included do
    #relations
    belongs_to :role
    has_many :payments
    has_one :exhibitor
    has_one :organizer

    accepts_nested_attributes_for :exhibitor
    accepts_nested_attributes_for :organizer
    # fields
    field :username,           type: String
    field :type,           type: String
    # callbacks
    before_validation :set_default_role
    # validataes
    validates :username, uniqueness: true
    validates :role, :username, presence: true
    # index
    index({ username: 1 }, { unique: true })

    private
    def set_default_role
      self.role ||= Role.find_by(name: 'professional_visitor')
    end

  end

end
