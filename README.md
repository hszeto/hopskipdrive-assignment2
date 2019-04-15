## An api that returns 5 closest cafes based on a given lat/lon coordinate.
### Download my Android app on your phone to see this api in action.
https://play.google.com/store/apps/details?id=com.gimbal_assignment.app

---
* Rails version 5.2.2
* Ruby version 2.5.1
* Run test locally:
  1. bundle install
  2. rake db:create
  3. rake db:migrate
  3. rake db:seed
  2. rake db:migrate RAILS_ENV=test 
  3. bundle exec rspec spec
---
### Usage with curl
```
curl -X GET 'https://gimbal-assignment.herokuapp.com/api/nearby?lat=34.087100&lon=-118.241705'
```
---
|Request| | |
|-|-|-|
|Resourse|GET https://gimbal-assignment.herokuapp.com/api/nearby| |
|url params|?lat=34.0342747&lon=-118.241705| Required: lat, lon|

|Response| | |
|-|-|-|
|Status|Body|Explanation|
|200|{"cafes": [{"name":"Big Bottle Coffee","lat":34.0390863,"lon":-118.2525317,"distance":0.6256077185224261}, {}... ], "radius": 1.2345}|OK
|422|{"error": "Invalid params"}| lat lon are not a float|
|422|{"error": "Missing params"}| lat lon is missing|
