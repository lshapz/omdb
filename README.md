Note: PUT and DELETE methods are not working from the front end because of CORS access issues, but they work in Postman. 


# Sinatra setup

* In a terminal window, navigate to omdb-back folder before all commands below
* To install ruby gems `bundle install`
* To create the development database: put your postgres password in line 7 of omdb-back/config/database.yml, then run `rake db:create`
* To setup the Movie model for the databse: `rake db:migrate` 
* To run the backend on port 9393: `bundle exec shotgun`

# Vue setup

* In a terminal window, navigate to omdb-front before all commands below
* To install the node modules: `npm install`
* To run the frontend on port 8080: `npm run serve`
