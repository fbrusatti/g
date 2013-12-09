class PropertyPdf < Prawn::Document

  def initialize(property, options = {})
    super()
    @options = options
    @property = property
  end
end
