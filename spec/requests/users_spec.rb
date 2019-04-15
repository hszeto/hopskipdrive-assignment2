RSpec.describe 'User API', type: :request do
  describe '/api/users' do
    let!(:user) { create :user}

    let(:valid_params) {{
      name: 'Testy Tester',
      email: 'testy@example.com'
    }}

    it 'create an user return 201' do
      post(
            '/api/users',
            params: valid_params.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )

      parsed_body = JSON.parse(response.body)

      expect(response.status).to eq(201)
      expect(parsed_body['id']).to eq User.last.id
    end

    it 'get all users return 200' do
      get('/api/users')

      parsed_body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(parsed_body.last['id']).to eq User.last.id
    end
  end
end
