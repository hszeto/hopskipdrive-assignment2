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