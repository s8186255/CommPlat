class Attachment::Flash < Attachment::Asset
  mount_uploader :asset, Attachment::FlashUploader
end