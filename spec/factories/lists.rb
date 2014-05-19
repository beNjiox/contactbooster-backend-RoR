FactoryGirl.define do
  factory :list do
    name { Faker::Lorem.word }
    position 0
  end
end