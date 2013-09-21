# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    sequence(:name)     { |n| "CustomerName#{n}" }
    sequence(:surname)  { |n| "CustomerSurname#{n}" }
  end
end
