FactoryBot.define do
  factory :book do
    author { Faker::Book.author } 
    title  { Faker::Book.title } 
  end
end