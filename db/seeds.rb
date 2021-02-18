# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PetApplication.destroy_all
Pet.destroy_all
Shelter.destroy_all
Application.destroy_all

FactoryBot.create(:pet)
FactoryBot.create(:shelter)
FactoryBot.create(:application)
FactoryBot.create(:pet_application)
# FactoryBot.create(:pet, id: 4, shelter_id: 2)
# FactoryBot.create(:pet, id: 5, shelter_id: 1)
# FactoryBot.create(:pet, id: 6, shelter_id: 1)
# FactoryBot.create(:pet, id: 7, shelter_id: 2)
# FactoryBot.create(:shelter, id: 1)
# FactoryBot.create(:shelter, id: 2)
# FactoryBot.create(:application, id: 1 )
# FactoryBot.create(:application, id: 2 )
# FactoryBot.create(:application, id: 3 )
# FactoryBot.create(:application, id: 4 )
# FactoryBot.create(:application, id: 5 )
# FactoryBot.create(:application, id: 6 )
