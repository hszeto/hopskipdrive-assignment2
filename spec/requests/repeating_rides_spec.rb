RSpec.describe 'RepeatingRides API', type: :request do
  let(:user) { create :user}

  describe 'POST /api/repeating-rides' do
    let(:valid_params){{
      days: [2, 4],
      frequency: 3,
      location: '12 3rd St. Los Angeles, CA 90014',
      time: '10:00 AM',
      user_id: user.id
    }}

    context 'when request is valid' do
      it 'create repeating ride' do
        post( 
          '/api/repeating-rides',
          params: valid_params.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

        expect(response.status).to eq(200)
      end
    end
  end
end