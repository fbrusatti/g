mobile_phone = { phone: " ", mobile_phone: "358478556" }

FactoryGirl.define do
  factory :customer do
    sequence(:name)     { |n| "CustomerName#{n}" }
    sequence(:surname)  { |n| "CustomerSurname#{n}" }
    phones mobile_phone
  end
end
