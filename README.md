# HopSkipDrive - Assignment 2

---
* Rails version 5.2.3
* Ruby version 2.5.1
* Run test locally:
  1. bundle install
  2. rake db:create
  3. rake db:migrate
  4. bundle exec rspec spec
---
### Association:
* User has_many RepeatingRide. RepeatingRide belongs_to User.
* RepeatingRide has_many Ride. Ride belongs_to RepeatingRide.

|users||
|-|-|
|name|string|
|email|string|

|repeating_rides||Explanation|
|-|-|-|
|frequency|integer|Number of recurring weeks. 1 to 4.|
|location|string|ex: "12 3rd St. Los Angeles, CA 90014"|
|time|string|ex: "02:34 PM"|
|days|text|Yaml Array. [0,1,2,3,4,5,6]. 0 is Sunday. 6 is Saturday|

|rides||Explanation|
|-|-|-|
|time|string|see above|
|location|string|see above|
|date|string|"2019-06-24"|
---
### Usage: Create a repeating ride.
```
curl -X POST \
  https://hopskipdrive-assignment2.herokuapp.com/api/repeating-rides \
  -H 'Content-Type: application/json' \
  -d '{
      "days": [2, 4, 6],
      "frequency": 2,
      "location": "123 4th St. Los Angeles, CA 90014",
      "time": "09:00 AM",
      "user_id": 1
}'
```
---
### API Request / Response:
|Request|Create a Repeating Ride||
|-|-|-|
|Resourse|POST https://hopskipdrive-assignment2.herokuapp.com/api/repeating-rides|Creates a repeating ride and rides according to days (day of week) and recurring week (frequency).|
|Headers|Content-Type: application/json|
|Body|{"days": [2, 4], "frequency": 3, "location": "12 3rd St. Los Angeles, CA 90014", "time": "10:00 AM","user_id": 1}|Days is the day of the week. Array of 0 to 6. 0 is Sunday, 6 is Saturday. Frequency is the number of recurring weeks. 1 to 4 weeks.|

|Response| | |
|-|-|-|
|Status|Body|Explanation|
|201|{"frequency": 3, "location": "12 3rd St. Los Angeles, CA 90014", "time": "10:00 AM", "days": [2,4], "user": {"email": "ucla@hotmail.com"}, "rides": [{"time": "10:00 AM", "location": "12 3rd St. Los Angeles, CA 90014", "date": "2019-04-16"}, ...{}],|Created
|422|{"error": message}|See response body or Warning Headers for details|
---
|Request|Get a Repeating Ride|Explanation|
|-|-|-|
|Resourse|GET https://hopskipdrive-assignment2.herokuapp.com/api/repeating-rides/:repeating_ride_id|repeating_ride_id is required|
|Headers|Content-Type: application/json|

|Response| | |
|-|-|-|
|Status|Body|Explanation|
|200|{"frequency": 3, "location": "12 3rd St. Los Angeles, CA 90014", "time": "10:00 AM", "days": [2,4], "user": {"email": "ucla@hotmail.com"}, "rides": [{"time": "10:00 AM", "location": "12 3rd St. Los Angeles, CA 90014", "date": "2019-04-16"}, ...{}],|OK
|422|{"error": message}|See response body or Warning Headers for details|
---
|Request|Update a Repeating Ride|Explanation|
|-|-|-|
|Resourse|PUT https://hopskipdrive-assignment2.herokuapp.com/api/repeating-rides/:repeating_ride_id|repeating_ride_id is required|
|Headers|Content-Type: application/json|
|Body|{"location": "DEFG St. Los Angeles, CA 90014","time": "01:00 PM"}|Update the location and/or time of a repeating ride and all associated rides|

|Response| | |
|-|-|-|
|Status|Body|Explanation|
|200|{"frequency": 3, "location": "12 3rd St. Los Angeles, CA 90014", "time": "10:00 AM", "days": [2,4], "user": {"email": "ucla@hotmail.com"}, "rides": [{"time": "10:00 AM", "location": "12 3rd St. Los Angeles, CA 90014", "date": "2019-04-16"}, ...{}],|OK
|422|{"error": message}|See response body or Warning Headers for details|
---
|Request|Delete a Repeating Ride|Explanation|
|-|-|-|
|Resourse|Delete https://hopskipdrive-assignment2.herokuapp.com/api/repeating-rides/:repeating_ride_id|Delete a repeating ride and all associated rides. repeating_ride_id is required|
|Headers|Content-Type: application/json|

|Response| | |
|-|-|-|
|Status|Body|Explanation|
|200|{}|OK
|422|{"error": message}|See response body or Warning Headers for details|
---
|Request|Update a Ride|Explanation|
|-|-|-|
|Resourse|PUT https://hopskipdrive-assignment2.herokuapp.com/api/rides/:ride_id|ride_id is required|
|Headers|Content-Type: application/json|
|Body|{"location": "123 Boardway. Los Angeles, CA 90014","time": "02:00 PM", "date": "2019-12-25"}|Update the location, date and/or time of a ride|

|Response| | |
|-|-|-|
|Status|Body|Explanation|
|200|{}|OK
|422|{"error": message}|See response body or Warning Headers for details|
---
|Request|Delete a Ride|Explanation|
|-|-|-|
|Resourse|Deletehttps://hopskipdrive-assignment2.herokuapp.com/api/rides/:ride_id|Delete a ride. ride_id is required.|
|Headers|Content-Type: application/json|

|Response| | |
|-|-|-|
|Status|Body|Explanation|
|200|{}|OK
|422|{"error": message}|See response body or Warning Headers for details|

---
### Edge cases tests
* When create ride on the last week of the year. Will the api create rides extend to the next year?
* If user update a repeating ride with an old date in the past. How should the api handles that?

---
### Performance challenge
For this assignment, I am allowing repeating ride of 4 weeks only. Max number of rides to create is 4weeks x 7days = 28 days, which is 28 rides.

The doc said repeating ride could continue for 1 year. That is 365 days, which is a max of 365 rides per repeating ride creation. Might consider using a gem called activerecord-import for bulk inserting data using ActiveRecord.
