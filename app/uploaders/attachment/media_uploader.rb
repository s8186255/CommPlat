# encoding: utf-8

class Attachment::MediaUploader < Attachment::AssetUploader

  def extension_white_list
    EXT_NAMES[:media]
  end
  def store_dir
    return "#{Rails.root}/uploads/media"
  end
end

