# README

This is an app that mimics TinyURL  
It allows users to submit an URL to get back a shortened one  
The short URL redirects back to the original URL  
There's IP address tracking of the visits to the short URLs  

If the long URL is already in the db, it returns the already generated short URL

* Ruby version  
ruby '2.5.3'  
rails 6.1.4

* Database  
The default sqlite3 is used  
run `bundle rails db:migrate` to setup the db  
indexing added to both url and token fields in the links table
because both were used for deduplication

* Routes  
All routes show up on the home page.  
The shortened URL and its info page dynamically shows up after submit.
However no graceful back or home ui were implemented for the links and info page. We'll have to use the browser back button, or manually enter the appropriate route

* Token Generation  
Given the suggested time spent on the project (90 mins!?), I opted for a very (maybe overly) simplistic approach.  
Token generation simply generate random token and query the database to see if it already exists.  
If it does, simply keep trying until one that doesn't exist appears.  
I do recognize this is a very simplistic strategy and can quickly run into scaling issues.  
A better approach as discussed by many system design discussions is to have a separate token generation service that generates and keeps track of used and unused tokens.
