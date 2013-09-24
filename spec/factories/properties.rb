# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :property do
    amount_rooms "3"
    title_to_print "Centrica Casa A Estrenar"
    address "Rivadabia 241"
    description "Living comedor con parque, en exelente esquina"
    amount_bathrooms "2"
    lot "100"
    meters_constructed "80"
    price "2900.00"
  end
end
