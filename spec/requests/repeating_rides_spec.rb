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
      time: '12:34 PM',
      location: 'ABC St. Los Angeles, CA 90038',
    }}

    let(:valid_ride_update_params) {{
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

      it 'create returns 200' do
        expect(response.status).to eq(201)
      end

      it 'update returns 200' do
        put(
          "/api/repeating-rides/#{RepeatingRide.last.id}",
          params: valid_update_params.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

        expect(response.status).to eq(200)
      end

      it 'delete returns 200' do
        delete(
          "/api/repeating-rides/#{RepeatingRide.last.id}",
          headers: { 'Content-Type' => 'application/json' }
        )

        expect(response.status).to eq(200)
      end

      it 'update a ride returns 200' do
        put(
          "/api/repeating-rides/#{RepeatingRide.last.id}/rides/#{RepeatingRide.last.rides.last.id}",
          params: valid_ride_update_params.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

        expect(response.status).to eq(200)
      end

      it 'delete a ride returns 200' do
        delete(
          "/api/repeating-rides/#{RepeatingRide.last.id}/rides/#{RepeatingRide.last.rides.last.id}",
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
          .to eq 'Validation failed: User must exist'
        expect(response.headers['Warning'])
          .to eq 'Validation failed: User must exist'
      end
    end
  end
end