FactoryGirl.define do
  factory :contact do
    lastname  { Faker::Name.last_name }
    firstname { Faker::Name.first_name }
    phone     { Faker::Number.number(10) }
  end
end
