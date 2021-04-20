require 'rails_helper'

RSpec.describe 'Books API', type: :request do
  describe 'index testing' do
    Book.destroy_all
    Author.destroy_all

    author = Author.create(
      first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, age: (15..85).to_a.sample 
      )

    2.times do
         author.books.create(title: Faker::Book.title, author_id: author.id)
       end

    it 'should return all books' do
      get '/api/v1/books'
      
      expect(response).to have_http_status(:success)
      
      expect(JSON.parse(response.body).size).to eq(2)
   end
  end

  describe 'create testing' do
    Book.destroy_all
    Author.destroy_all

    it 'can create a new book record' do
      expect(Author.all.count).to eq(0)
      expect {
        post '/api/v1/books', params: {
          book:   { title: Faker::Book.title },
          author: { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, age: (15..85).to_a.sample }
        }
        expect(response).to have_http_status(:created)
      }.to change { Book.count }.from(0).to(1)

      expect(Author.all.count).to eq(1)
    end

    it 'responds with unprocessable_entity sad path with author initials' do
      post '/api/v1/books', params: {book: { title: Faker::Book.title, author: "AB"} }

      expect(response).to have_http_status(:unprocessable_entity)

    end

    it 'responds with unprocessable_entity sad path with inconplete title' do
      post '/api/v1/books', params: {book: { title: 'ab', author: Faker::Book.author} }

      expect(response).to have_http_status(:unprocessable_entity)

    end
  end

  describe 'delete testing' do
    let!(:book) { FactoryBot.create(:book) }

    it 'deletes a book record' do
      expect {
        delete "/api/v1/books/#{book.id}"
      }.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end