module BaseUploader
  extend ActiveSupport::Concern

  included do
    include CarrierWave::MiniMagick
    if Rails.env.test?
      storage :file
    else
      storage :fog
    end
  end

  def default_url
     "http://placehold.it/330&text=pic"
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{id_partition(model)}"
  end

  private

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.uuid)
  end

  def id_partition(attachment)
    case id = attachment.id
    when Integer
      ("%09d" % id).scan(/\d{3}/).join("/")
    when String
      id.scan(/.{3}/).first(3).join("/")
    else
      nil
    end
  end

end