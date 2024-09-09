# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Category.create(id: 1, name: 'バックエンド') unless Category.exists?(id: 1, name: 'バックエンド')
Category.create(id: 2, name: 'フロントエンド') unless Category.exists?(id: 2, name: 'フロントエンド')
Category.create(id: 3, name: 'インフラ') unless Category.exists?(id: 3, name: 'インフラ')
