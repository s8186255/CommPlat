class Attachment::Image < Attachment::Asset
  mount_uploader :asset, Attachment::ImageUploader

  belongs_to :card
  belongs_to :card_type

end
