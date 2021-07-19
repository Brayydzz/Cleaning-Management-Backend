# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Client.destroy_all
ContactInformation.destroy_all
Address.destroy_all
ServiceType.destroy_all
User.destroy_all
Job.destroy_all

address1 = Address.create(street_number: "1", street_address: "Fake rd", suburb: "Brisbane", state: "QLD",
                          postcode: "4000")

contactInfo = ContactInformation.create(phone_number: "04987654", email: "blah@blah.com", first_name: "Bob",
                                        last_name: "Jones", address_id: address1.id)

user1 = User.create(email: "a@b.com", password: "password", isAdmin: true, contact_information_id: contactInfo.id)
user2 = User.create(email: "a@b.c", password: "password", isAdmin: false, contact_information_id: contactInfo.id)
# user2 = User.create(email: "foo@bar.com", password:"password", isAdmin: false)
# user3 = User.create(email: "james@perrin.com", password:"password", isAdmin: false)
# user4 = User.create(email: "dane@thomson.com", password:"password", isAdmin: false)
# user5 = User.create(email: "brayden@ogorman.com", password:"password", isAdmin: false)

service1 = ServiceType.create(name: "Hour Clean", hours_needed: 1)
service2 = ServiceType.create(name: "Full Clean", hours_needed: 8)
service3 = ServiceType.create(name: "Half Clean", hours_needed: 4)

service1.bookings.create(first_name: "Jack", last_name: "Daniel", email: "jack@daniel.com",
                         body: "I need a quick clean because my lady is lazy", phone_number: "0411111111")
service1.bookings.create(first_name: "Jim", last_name: "Beam", email: "jim@beam.com",
                         body: "Help my house is a mess and I have a inspection soon", phone_number: "0422222222")
service1.bookings.create(first_name: "Johnny", last_name: "Walker", email: "johnny@walker.com",
                         body: "I'm soo lonely, I just want someone to talk to.", phone_number: "0433333333")
service2.bookings.create(first_name: "Captain", last_name: "Morgan", email: "captain@morgan.com",
                         body: "AAAAAARRRRRRRRRRHHHFGGGGGGGG!!!!!", phone_number: "0444444444")
service2.bookings.create(first_name: "Jack", last_name: "Sparrow", email: "jack@sparrow.com",
                         body: "I’m dishonest, and a dishonest man you can always trust to be dishonest. Honestly.
                          It’s the honest ones you want to watch out for, because you can never predict
                         when they’re going to do something incredibly … stupid.", phone_number: "0455555555")
service2.bookings.create(first_name: "Brittany", last_name: "Spears", email: "brittany@spears.com",
                         body: "Baby clean me one more time", phone_number: "0466666666")
service3.bookings.create(first_name: "Ben", last_name: "Dover", email: "ben@dover.com",
                         body: "I'm struggling to reach down to clean the dirt off my floors,
                          I need a half day clean to get it back to standard", phone_number: "0477777777")
service3.bookings.create(first_name: "Peter", last_name: "Freely", email: "p@freely.com",
                         body: "The house smells. can you help me?", phone_number: "0488888888")
service3.bookings.create(first_name: "Al", last_name: "Coholic", email: "al@coholic.com",
                         body: "Looking for a half day clean before my missus gets back next week", phone_number: "0499999999")
service3.bookings.create(first_name: "Seymour", last_name: "Butz", email: "seymour@butz.com",
                         body: "I want a half day clean every Wednesday ongoing. Between 12pm and 4pm",
                         phone_number: "0412345678")

client1 = Client.create(contact_information_id: contactInfo.id)

job1 = Job.create(address_id: address1.id, service_type_id: service1.id, due_date: DateTime.now, client_id: client1.id, reoccuring: true, reoccuring_length: 7, user_id: user2.id)

# booking
# first_name: string
# last_name: string
# email: string
# body: string
# service_type: int
# phone_number: string
