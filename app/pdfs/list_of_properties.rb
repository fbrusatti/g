class ListOfProperties < Prawn::Document
  include PdfProperty

  def initialize(options)
    super()
    @options = options
    structure
  end

  def structure
    header({})
    move_down 10
    title(@options[:title])
    @options[:properties].each do |property|
      formatted_text [
        { text: "#{property.id} - ", styles: [:bold] },
        { text: "#{property.influence_zone.upcase} ", styles: [:underline] },
        { text: info(property) },
        { text: price_with_money(property), styles: [:bold] }
      ]
    end
  end

  def info(property)
    "#{property.address.upcase}: " +
    ((property.amount_rooms ||0) > 0 ? "#{property.amount_rooms} DORM" : 'MONOAMBIENTE')
  end

  def price_with_money(property)
    price = ""
    if @options[:transaction].present?
      price = property.send("to_#{@options[:transaction]}").to_s
      money = property.try { |p| p.send("money_to_#{@options[:transaction]}").try(:name) }.to_s
    end
    price.present? ? "...$#{price} #{money if money =~ /Dolar/}" : ''
  end
end
