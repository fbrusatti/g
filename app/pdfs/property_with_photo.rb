class PropertyWithPhoto < Prawn::Document
  include PdfProperty

  def initialize(property, options)
    super()
    @property = property
    @options = options
    @track_points, @errors = {}, {}
    structure
  end

  def structure
    header({ with_ref: true })
    bounding_box([0, cursor - 10], width: bounds.width, height:bounds.height - 30) do
      title(@property.title_to_print)
      @track_points[:photo] = cursor
      photo({ posx: 10, posy: cursor, photo: @options[:photo] })
      details({ posx: cursor, posy: @track_points[:photo] })
      prices({ posx: 365, posy: cursor - 10,
               to_rent: @options[:with_to_rent],
               to_sale: @options[:with_to_sale] })
      map({ posx: 10, posy: @track_points[:photo] - 270 }) if @options[:with_map]

      if @options[:with_address]
        posx = @options[:with_map].present? && @errors[:map].blank? ? 220 : 10
        posy = @options[:with_map].present? && @errors[:map].blank? ? cursor + 200 : @track_points[:photo] - 270
        address({ posx: posx, posy: posy})
      end

      if @options[:with_map].present? && @errors[:map].blank?
        posy = 120
      else
        posy = @options[:with_address] ? cursor - 10 : @track_points[:photo] - 280
      end
      description({ posx: 10, posy: posy})
      stroke_bounds
    end
  end
end
