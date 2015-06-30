class Attachment::Media < Attachment::Asset
  mount_uploader :asset, Attachment::MediaUploader
end