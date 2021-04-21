require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  it 'pagination function has a max limit of 20' do
       Book.destroy_all
       Author.destroy_all
   
       author = Author.create(
         first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, age: (15..85).to_a.sample 
         )
   
       30.times do
            author.books.create(title: Faker::Book.title, author_id: author.id)
          end
  
       expect(Book).to receive(:limit).with(20).and_call_original
  
       get :index, params: { limit: 30 }
  end
end
