# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first
Manager.create(username: "Man", email: "dada", password: "dadsa")
pr = Project.create(user_id: 1)
pr.users << Developer.create(username: "Dev", email: "dadaass", password: "dadsa")
pr.users << QA.create(username: "QA", email: "dadaaaaaaa", password: "dadsa")

