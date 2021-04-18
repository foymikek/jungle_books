require 'rails_helper'

RSpec.describe 'Books API', type: :request do
  describe 'index testing' do
      it 'should return all books' do
        2.times do
          FactoryBot.create(:book)
        end
        
        get '/api/v1/books'
        
        expect(response).to have_http_status(:success)
        
        expect(JSON.parse(response.body).size).to eq(2)
   end
  end

  describe 'create testing' do
    it 'can create a new book record' do
      expect {
        post '/api/v1/books', params: {book: { title: Faker::Book.title, author: Faker::Book.author} }
  
        expect(response).to have_http_status(:created)
      }.to change { Book.count }.from(0).to(1)
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
end