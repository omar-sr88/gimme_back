# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



User.create!(name:  "Omar Ramalho",
             email: "omar.sr88@gmail.com",
             nick:  "oscher88",
             password:              "omar123",
             password_confirmation: "omar123",
             super: true,
             activated: true,
             activated_at: Time.zone.now)

UserInfo.create!(user_id: 1,
                 phone_number: "555-555-555",
                 contact_email: "another@email.com",
                 address: "My house"
  )

10.times do |n|
  name  = Faker::Name.name
  nick = ''
  nick  = Faker::Name.last_name until nick.size > 4
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               nick: nick,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

Item.create!(name: 'Livro Magic',
        description: 'Guia de alara,novinho, sem nada de mais',
        date_lended: '11/01/2014 13:23',
        initial_return_date: '12/01/2014',
         owner_id: 1 ,
          recipient_id: 2)

Item.create!(name: 'Isqueiro',
         description: 'Novinho, com marcel, nao volta mais',
         date_lended: '04/01/2016 13:23',
         initial_return_date: '05/01/2016',
         owner_id: 1 ,
          recipient_id: 2) 

Item.create!(name: 'Rock band',description: 'Bateria, microfone a porra toda com antonio',
  date_lended: '1/01/2016 13:23', initial_return_date: '2/01/2016', owner_id: 2 ,
          recipient_id: 1)