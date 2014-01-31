class PropertyPdfFactory
  class << self
    def create(*property, options)
      return ListOfProperties.new(options) if property.blank?
      options[:photo].present? ? PropertyWithPhoto.new(property[0], options)
                               : PropertyWithoutPhoto.new(property[0], options)
    end
  end
end
