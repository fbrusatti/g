module PdfProperty
  API_KEY = 'AIzaSyC39Ryjaoo_jjHzY3YfWliYExcPKNvbLZk'
  MAP_PATH = 'http://maps.googleapis.com/maps/api/staticmap'
  ATTR_PATH = 'activerecord.attributes.property'

  def header(opt)
    y_pos = cursor
    image 'public/gutierrez_header_img.jpg', { height: 50 }
    options = { at: [200, y_pos], height: 50, size: 24, valign: :center, style: :bold }
    text_box "Ref: #{@property.id}", options if opt[:with_ref]
  end

  def title(str)
    options = { align: :center, size: 24, style: :bold, inline_format: true }
    pad_top(5) do
      text("<u>#{str}</u>", options)
    end
  end

  def photo(opt)
    path = "public/#{opt[:photo]}"
    bounding_box([opt[:posx] , opt[:posy]], width: 350) do
      image path, fit: [350, 350]
      stroke_bounds
    end
  end

  def details(opt)
    rows = []
    %w{amount_rooms amount_bathrooms lot meters_constructed}.each do |detail|
      rows << [I18n.t("#{ATTR_PATH}.#{detail}"), @property.send("#{detail}").to_s]
    end
    bounding_box([opt[:posx] , opt[:posy]], width: 150) { table rows }
  end

  def prices(opt)
    prices = []
    %w{to_rent to_sale}.each do |price|
      if opt[price.to_sym]
        value = "#{@property.send(price)} #{@property.send('money_' + price).try :name}"
        prices << [I18n.t("#{ATTR_PATH}.#{price}"), value]
      end
    end
    bounding_box([opt[:posx], opt[:posy]], width: 150) { table prices } unless prices == []
  end

  def map(opt)
    latlong = "#{@property.latitude},#{@property.longitude}"
    path = "#{MAP_PATH}?zoom=16&size=250x250&key=#{API_KEY}&sensor=false&markers=#{latlong}"
    img = open(path) rescue @errors[:map] = 'not has conection'
    bounding_box([opt[:posx], opt[:posy]], width: 200) do
      image img, { fit: [200,200] } if @errors[:map].blank?
      stroke_bounds
    end
  end

  def address(opt)
    addrs = []
    %w{address influence_zone}.each do |addr|
      addrs << [I18n.t("#{ATTR_PATH}.#{addr}"), @property.send(addr)]
    end
    bounding_box([opt[:posx], opt[:posy]], width: 300) { table addrs }
  end

  def description(opt)
    options = { at: [opt[:posx], opt[:posy]], width: bounds.width - 30, height: 150,
                overflow: :shrink_to_fit, min_font_size: 7, align: :justify, size: 20 }
    text_box @property.description_to_print, options
  end
end
