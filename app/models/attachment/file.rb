class Attachment::File < Attachment::Asset
  mount_uploader :asset, Attachment::FileUploader
end