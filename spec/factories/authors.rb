FactoryBot.define do
  factory :author do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    age { (15..85).to_a.sample }
  end
end
