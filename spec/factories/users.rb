# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@mail.com"
  end

  factory :user do
    email
    password "pawssword"
    password_confirmation "pawssword"
  end
end