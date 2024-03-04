require "mini_magick"

Rails.application.config.active_storage.variant_processor = :mini_magick

if Rails.application.config.active_storage.variant_resizers.present?
  Rails.application.config.active_storage.variant_resizers[:mini_magick] = lambda do |blob|
    # Verifica se o blob não é nulo
    if blob
      # Redimensionar a imagem para diferentes tamanhos com base na chave do blob
      case blob.key
      when /thumb/
        MiniMagick::Image.open(blob).resize("200x200>")
      when /medium/
        MiniMagick::Image.open(blob).resize("400x400>")
      else
        MiniMagick::Image.open(blob).resize("600x600>")
      end
    end
  end
end
