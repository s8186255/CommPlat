# encoding: utf-8

class Attachment::FileUploader < Attachment::AssetUploader

  def extension_white_list
    EXT_NAMES[:file]
  end
  def store_dir
    return "#{Rails.root}/uploads/files"
  end
end

