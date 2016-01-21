# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Category.create!(name: "Business", private: false, predefined: true)
Category.create!(name: "Tech", private: false, predefined: true)
Category.create!(name: "Health", private: false, predefined: true)
Category.create!(name: "Entertainment", private: false, predefined: true)
Category.create!(name: "Life", private: false, predefined: true)
Category.create!(name: "Design", private: false, predefined: true)
Category.create!(name: "Language", private: false, predefined: true)
Category.create!(name: "Travel", private: false, predefined: true)
