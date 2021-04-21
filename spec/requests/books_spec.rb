require 'rails_helper'

RSpec.describe 'Books API', type: :request do
  describe 'index testing' do
    
    it 'returns all books' do
      Book.destroy_all
      Author.destroy_all
  
      author = Author.create(
        first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, age: (15..85).to_a.sample 
        )
  
      2.times do
           author.books.create(title: Faker::Book.title, author_id: author.id)
         end
      get '/api/v1/books'
      
      expect(response).to have_http_status(:success)
      expect(response_body).to eq(
        [
          {
          id: Book.all.first.id,
          title: Book.all.first.title,
          author: "#{Book.first.author.first_name} #{Book.first.author.last_name}",
          author_age: Book.first.author.age
        },
        {
          id: Book.all.last.id,
          title: Book.all.last.title,
          author: "#{Book.last.author.first_name} #{Book.last.author.last_name}",
          author_age: Book.last.author.age
        }
      ]
      )
      
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'returns a paginated subset of books based on limit.' do
      Book.destroy_all
      Author.destroy_all
  
      author = Author.create(
        first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, age: (15..85).to_a.sample 
        )
  
      2.times do
           author.books.create(title: Faker::Book.title, author_id: author.id)
         end

      get '/api/v1/books', params: {
        limit: 1
      }
      expect(response).to have_http_status(:success)
      expect(response_body).to eq(
      [
        {
          id: Book.all.first.id,
          title: Book.all.first.title,
          author: "#{Book.first.author.first_name} #{Book.first.author.last_name}",
          author_age: Book.first.author.age
        }
      ]
      )
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it 'returns a paginated subset of books based on limit and offset.' do
      Book.destroy_all
      Author.destroy_all
  
      author = Author.create(
        first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, age: (15..85).to_a.sample 
        )
  
      2.times do
           author.books.create(title: Faker::Book.title, author_id: author.id)
         end

      get '/api/v1/books', params: {
        limit: 1,
        offset: 1
      }
      expect(response).to have_http_status(:success)
      expect(response_body).to eq(
      [
        {
          id: Book.all.last.id,
          title: Book.all.last.title,
          author: "#{Book.last.author.first_name} #{Book.last.author.last_name}",
          author_age: Book.last.author.age
        }
      ]
      )
      expect(JSON.parse(response.body).size).to eq(1)
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

      expect(response_body).to eq(
        {
          id: Book.all.last.id,
          title: Book.all.last.title,
          author: "#{Book.last.author.first_name} #{Book.last.author.last_name}",
          author_age: Book.last.author.age
        }
      )
      expect(Author.all.count).to eq(1)
    end

    it 'responds with unprocessable_entity sad path with inconplete title' do
      Book.destroy_all
      Author.destroy_all

      post '/api/v1/books', params: {
        book: { title: 'ab'},
        author: { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, age: (15..85).to_a.sample }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'delete testing' do
    it 'deletes a book record' do
      Book.destroy_all
      Author.destroy_all
  
      author = Author.create(
          first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, age: (15..85).to_a.sample 
          )
    
      book = author.books.create(title: Faker::Book.title, author_id: author.id)

      expect {
        delete "/api/v1/books/#{book.id}"
      }.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end