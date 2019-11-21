class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  # process resize_and_pad(600, 600, background = :transparent, gravity = 'Center')

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*args)
    # For Rails 3.1+ asset pipeline compatibility:
    # ActionController::Base.helpers.asset_path(
    # "fallback/" + [version_name, "default.png"].compact.join('_'))

    "/images/" + [version_name, "default.png"].compact.join('_')
  end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # 画像サイズ設定
  # 詳細表示用：600 * 600の正方形に整形
  version :thumb600 do
    process resize_and_pad(600, 600, background = :transparent, gravity = 'Center')
  end

  # 一覧表示用：200 * 200の正方形に中央から切り抜き
  version :thumb200 do
    process resize_to_fill: [200, 200, "Center"]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
