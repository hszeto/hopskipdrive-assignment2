Rails.application.routes.draw do
  scope 'api' do
    get    '/repeating-rides/:repeating_ride_id', to: 'repeating_rides#show'
    post   '/repeating-rides',                    to: 'repeating_rides#create'
    put    '/repeating-rides/:repeating_ride_id', to: 'repeating_rides#update'
    delete '/repeating-rides/:repeating_ride_id', to: 'repeating_rides#destroy'

    put    '/rides/:ride_id', to: 'rides#update'
    delete '/rides/:ride_id', to: 'rides#destroy'
  end
end
