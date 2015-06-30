# encoding: utf-8

class Attachment::ImageUploader < Attachment::AssetUploader

  #include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  def extension_white_list
    EXT_NAMES[:image]
  end
  def store_dir
    "uploads/images"
  end

  #version :thumb do
    #process :resize_to_fill => [100,180]
  #end

end

