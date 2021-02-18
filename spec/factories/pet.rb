FactoryBot.define do
  factory :pet do
    image {""}
    name { Faker::Creature::Dog.name }
    description { Faker::Creature::Dog.breed }
    approximate_age { Faker::Number.between(from: 1, to: 10) }
    sex { "male" or "female"}
    shelter
  end
end
