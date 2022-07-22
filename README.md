# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

Ruby Version = 2.7.0

Configuration Instructions
1. Clone repository
2. Run bundle install and ensure the presence of postgresql database (you will need to install and configure it if you haven't already done so)
3. Set Environment variables (APPLICATION_HOST, DATABASE_NAME, DATABASE_PASSWORD, GMAIL_USERNAME, GMAIL_PASSWORD, CLOUDINARY_URL)
4. Run rails db:setup to create database
5. Start the rails server
