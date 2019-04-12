Rails.application.routes.draw do
  scope 'api' do
    post '/repeating-rides', to: 'repeating_rides#create'
  end
end
