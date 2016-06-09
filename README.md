### Introduction

This app serves an API using data from the Washington State Department of Education. It currently serves a limited amount of data, but I will continue to add to this as time allows. The production app includes documentation of how to use each endpoint.

This was built as an independent study project during module 4 at the Turing School of Software and Design.

##### Current Endpoints

* Districts: returns a list of all districts and their county and Educational Service District
* Demographics:
  * District: returns student demographics in specified school district & specified school year
  * Data is currently available for the 2013-2014 school year, but more will be added shortly
* Graduation:
  * District: returns graduation data in specified school district & specified school year, broken down by student demographic

### Production

The production app can be found [here](https://wadoe-api.herokuapp.com/) - this will take you to documentation for using the API

### Stack

* Ruby on Rails
* SwaggerAPI
* RSpec

### Local Setup

1. Clone down the repository
2. From the project directory:
  * `bundle`
  * `rake db:create db:migrate db:import_demographic_data`

### Testing

The test suite is written using RSpec, and relies on model and controller tests. To run it, once the repository has been set up locally, run `rspec` from the root directory
