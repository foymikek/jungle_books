require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /authenticate' do
    it 'authenticates the client' do
      post api_v1_authenticate_index_path, params: {
        username: 'jungeldealer',
        password: 'passwurdburd'
      }

      expect(response).to have_http_status(:created)
      expect(response_body).to eq(
        {
          token: '123'
        }
      )
    end

    it 'returns erros when username is missing' do
      post api_v1_authenticate_index_path, params: {
        username: nil,
        password: 'passwurdburd'
      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq(
        {
          error: "param is missing or the value is empty: username"
        }
      )
    end
    
    it 'returns error when the password is missing' do
      post api_v1_authenticate_index_path, params: {
        username: 'jungeldealer',
        password: nil
      }
  
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq(
        {
          error: "param is missing or the value is empty: password"
        }
      )
    end
  end
end