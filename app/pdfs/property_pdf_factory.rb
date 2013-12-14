class PropertyPdfFactory
  class << self
    def create(property, options)
      options[:photo].present? ? PropertyWithPhoto.new(property, options)
                               : PropertyWithoutPhoto.new(property, options)
    end
  end
end
