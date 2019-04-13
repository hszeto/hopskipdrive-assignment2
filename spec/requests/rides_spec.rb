RSpec.describe 'RepeatingRides API', type: :request do
  let(:user) { create :user}

  describe 'POST /api/repeating-rides' do
    let(:valid_params) {{
      days: [2, 4],
      frequency: 3,
      location: '12 3rd St. Los Angeles, CA 90014',
      time: '10:00 AM',
      user_id: user.id
    }}

    let(:valid_update_params) {{
      time: '11:22 AM',
      location: 'DEF Rd. Los Angeles, CA 90038',
    }}

    context 'When request is valid' do
      before do
        # create repeating ride
        post( 
          '/api/repeating-rides',
          params: valid_params.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
      end

      it 'update a ride returns 200' do
        put(
          "/api/rides/#{RepeatingRide.last.rides.last.id}",
          params: valid_update_params.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

        expect(response.status).to eq(200)
      end

      it 'delete a ride returns 200' do
        delete(
          "/api/rides/#{RepeatingRide.last.rides.last.id}",
          headers: { 'Content-Type' => 'application/json' }
        )

        expect(response.status).to eq(200)
      end
    end

    context 'When request is invalid' do
      it 'missing params returns 422' do
        post( 
          '/api/repeating-rides',
          headers: { 'Content-Type' => 'application/json' }
        )

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['error'])
          .to eq "Validation failed: User must exist, Frequency can't be blank, Days can't be blank, Time can't be blank, Location can't be blank"
        expect(response.headers['Warning'])
          .to eq "Validation failed: User must exist, Frequency can't be blank, Days can't be blank, Time can't be blank, Location can't be blank"
      end
    end
  end
end