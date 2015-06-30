require 'carrierwave/mongoid'

class Attachment::Asset
  include Mongoid::Document
  include Mongoid::Timestamps

  field :file_size, :type => Integer
  field :file_type, :type => String
  field :owner_id, :type => String
  field :asset_type, :type => String
  #belongs_to :item

  mount_uploader :asset, Attachment::AssetUploader

  validates :asset, presence: true

  before_save :update_asset_attributes

  def self.collection_name
    :attachment_assets
  end

  private
  def update_asset_attributes
    if asset.present? && asset_changed?
      self.file_size = asset.file.size
      self.file_type = asset.file.content_type
    end
  end
end
