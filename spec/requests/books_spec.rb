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
end