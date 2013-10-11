price_hash = { to_sale: "150000", to_rent: "2500" }

FactoryGirl.define do
  factory :property do
    amount_rooms "3"
    title_to_print "Centrica Casa A Estrenar"
    address "Rivadabia 241"
    description "Living comedor con parque, en exelente esquina"
    amount_bathrooms "2"
    lot "100"
    meters_constructed "80"
    type_transaction 'Venta'
    prices price_hash
  end
end
