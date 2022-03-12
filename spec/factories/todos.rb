FactoryBot.define do
  factory :todo do
    title { Faker::Verb.base.capitalize + " " + Faker::Hobby.activity }
    is_completed { [false, true].sample }
  end
end
