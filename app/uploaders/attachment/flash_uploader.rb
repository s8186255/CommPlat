# encoding: utf-8

class Attachment::FlashUploader < Attachment::AssetUploader

  def extension_white_list
    EXT_NAMES[:flash]
  end
  def store_dir
    return "#{Rails.root}/uploads/flash"
  end
end

