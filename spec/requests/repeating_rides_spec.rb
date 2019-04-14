RSpec.describe 'RepeatingRides API', type: :request do
  let(:user) { create :user}

  describe '/api/repeating-rides' do
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

    context 'When request is valid' do
      before do
        # create repeating ride
        post( 
          '/api/repeating-rides',
          params: valid_params.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
      end

      it 'get returns 200' do
        get("/api/repeating-rides/#{RepeatingRide.last.id}")
        parsed_body = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(parsed_body['user']['email']).to eq user.email
        expect(parsed_body['rides'].size).to eq Ride.all.size
      end

      it 'create returns 201' do
        expect(response.status).to eq(201)
        parsed_body = JSON.parse(response.body)

        expect(parsed_body['user']['email']).to eq user.email
        expect(parsed_body['rides'].size).to eq Ride.all.size
      end

      it 'update repeating_ride and related rides returns 200' do
        put(
          "/api/repeating-rides/#{RepeatingRide.last.id}",
          params: valid_update_params.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

        parsed_body = JSON.parse(response.body)

        expect(response.status).to eq(200)
        expect(parsed_body['location']).to eq 'ABC St. Los Angeles, CA 90038'
        expect(parsed_body['rides'].last['location']).to eq 'ABC St. Los Angeles, CA 90038'
      end

      it 'delete returns 200' do
        delete(
          "/api/repeating-rides/#{RepeatingRide.last.id}",
          headers: { 'Content-Type' => 'application/json' }
        )

        expect(response.status).to eq(200)
      end
    end

    context 'When request is invalid' do
      before do
        # create repeating ride
        post( 
          '/api/repeating-rides',
          params: valid_params.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
      end

      it 'missing params returns 422' do
        post( 
          '/api/repeating-rides',
          headers: { 'Content-Type' => 'application/json' }
        )

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['error'])
          .to eq "param is missing or the value is empty: repeating_ride"
        expect(response.headers['Warning'])
          .to eq "param is missing or the value is empty: repeating_ride"
      end

      it 'missing params returns 422' do
        put( 
          '/api/repeating-rides/999',
          headers: { 'Content-Type' => 'application/json' }
        )

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['error'])
          .to eq "Couldn't find RepeatingRide with 'id'=999"
        expect(response.headers['Warning'])
          .to eq "Couldn't find RepeatingRide with 'id'=999"
      end

      it 'missing params returns 422' do
        put( 
          "/api/repeating-rides/#{RepeatingRide.last.id}",
          params: valid_update_params.merge(frequency: 2).to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['error'])
          .to eq "unknown attribute 'frequency' for Ride."
        expect(response.headers['Warning'])
          .to eq "unknown attribute 'frequency' for Ride."
      end

      it 'weekly frequency > 4 returns 422' do
        post(
          '/api/repeating-rides',
          params: valid_params.merge(frequency: 5).to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['error'])
          .to eq 'Cannot repeat for more than a month'
        expect(response.headers['Warning'])
          .to eq 'Cannot repeat for more than a month'
      end

      it 'days is not within [0,1,2,3,4,5,6] returns 422' do
        post(
          '/api/repeating-rides',
          params: valid_params.merge(days: [2,4,7]).to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['error'])
          .to eq 'Invalid day. Use 0 for Sunday, 6 for Saturday.'
        expect(response.headers['Warning'])
          .to eq 'Invalid day. Use 0 for Sunday, 6 for Saturday.'
      end
    end
  end
end