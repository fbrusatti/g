class PropertyWithoutPhoto < Prawn::Document
  include PdfProperty

  def initialize(property, options)
    super()
    @property = property
    @options = options
    @errors = {}
    structure
  end

  def structure
    header
    bounding_box([0, cursor - 10], width: bounds.width, height:bounds.height - 30) do
      title
      details({ posx: 20, posy: cursor - 10 })
      prices({ posx: 20, posy: cursor - 10,
               to_rent: @options[:with_to_rent],
               to_sale: @options[:with_to_sale] })
      map({ posx: 20, posy: cursor - 10 }) if @options[:with_map]

      if @options[:with_address]
        posx = @options[:with_map].present? && @errors[:map].blank? ? 230 : 20
        posy = @options[:with_map].present? && @errors[:map].blank? ? cursor + 200 : cursor - 10
        address({ posx: posx, posy: posy})
      end

      posy = @options[:with_map].present? && @errors[:map].blank? ? 200 : cursor - 10
      description({ posx: 20, posy: posy})
      stroke_bounds
    end
  end
end
