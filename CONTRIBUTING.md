# Contribute to Feminizidmap

## About the project

Feminizidmap is a volunteer-based, activist research project documenting femi(ni)cides in Germany. 

To support the research effort, we also develop software to help volunteers with the documentation work and, in the future, provide data and automated visualizations and reports with the help of that data. 

All code is open source can be found under the Feminizidmap GitHub organization https://github.com/feminizidmap/.

## Tech stack

The main Feminizidmap application is called **mapper** (this repository) and takes care of user management, data entry and exposing data via an API. It is split into a backend and frontend. 
The backend is a standard Ruby on Rails app talking to a Postgres database. 
The frontend is a VueJS app using standard Vue components (like vue-router, vuex, vue-i18n etc). 
The deployment setup uses Docker and docker-compose, and everything is hosted on a VPS.

We’re also planning a map-based visualization app that consumes data from the mapper API. This will most likely also be a VueJS app with either Leaflet or Mapbox GL JS for map rendering.

## How can you help?

We’re looking for help on both the front- and backend, contributors to documentation and translation and with an interest in our vision.

If you are interested in contributing please contact me directly via mail@lislis.de or open a ticket on the issue tracker and ping me @lislis. For bigger tasks/ small projects in mapper created some labels that you can check out.

There is the possibility of paying you for your work if you make a significant contribution to the project.

I’m working on writing more documentation to get started and tickets for smaller tasks that can easily be picked up. But feel free to ask questions in tickets, everything is still pretty new and often it’s not just you who has a certain question! In any case, questions and feedback are welcome and help me onboard you and others!

