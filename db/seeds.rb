# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: "管理者",email: "admin@sample.com", password: "password",password_confirmation:"password",admin: true)
Base.create(data_age: 0.0, min_weight: 0.1,max_weight: 0.1)
Base.create(data_age: 0.1, min_weight: 0.4,max_weight: 0.5)
Base.create(data_age: 0.2, min_weight: 0.95,max_weight: 1.0)
Base.create(data_age: 0.3, min_weight: 1.0,max_weight: 1.5)
Base.create(data_age: 0.6, min_weight: 2.5,max_weight: 3.0)
Base.create(data_age: 0.9, min_weight: 3.0,max_weight: 3.5)
Base.create(data_age: 1.0, min_weight: 3.0,max_weight: 4.0)
Base.create(data_age: 1.1, min_weight: 3.0,max_weight: 4.5)
Base.create(data_age: 1.2, min_weight: 3.0,max_weight: 5.0)