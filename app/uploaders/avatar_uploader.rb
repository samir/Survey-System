# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  process :resize_to_fit => [800, 800]
  process :convert => 'png'
  
  version :thumb do
    process :resize_to_fill => [200,200]
  end
  
  version :thumb_small do
    process :resize_to_fill => [60,60]
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "avatar.jpg" if original_filename
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
end
