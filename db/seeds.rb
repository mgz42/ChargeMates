require "open-uri"
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Création d'un hash pour stocker les données des voitures électriques
# db/seeds.rb

# Création d'un hash pour stocker les données des voitures électriques

# Création des modèles de voitures électriques à partir du hash

# voitures_electriques.each do |marque, details|
#   details['Modeles'].each do |modele|
#     Vehicle.create(
#       marque: marque,
#       modele: modele,
#       type_prise: details['Type_prise'],
#       puissance_maximale_recharge: details['Puissance_maximale_recharge']
#     )
#   end
# end

# profil 1
fileMarine = URI.open("https://i.ibb.co/5RvJNg5/Sans-titre.jpg")
marine = User.create(username: "marine_road", email: "marine@wagon.com", password: "123456", xp: 27550, wheel: Time.now - 60 * 60 * 24, seriestart: Time.now - 60 * 60 * 24 * 9, seriecurrent: Time.now, order: 65 )
marine.photo.attach(io: fileMarine, filename: "Sans-titre.jpg", content_type: "image/png")
marine.save

# profil 2
fileHonorine = URI.open("https://i.ibb.co/vJP0vMc/Capture-d-cran-2024-03-13-153535.png")
honorine = User.create(username: "h0n0rin3", email: "honorine@wagon.com", password: "123456", xp: 16350, wheel: Time.now - 60 * 60 * 24, seriestart: Time.now - 60 * 60 * 24 * 5, seriecurrent: Time.now, order: 39 )
honorine.photo.attach(io: fileHonorine, filename: "Capture-d-cran-2024-03-13-153535.png", content_type: "image/png")
honorine.save

# profil 3
fileBenoit = URI.open("https://i.ibb.co/K5pnKWv/Capture-d-cran-2024-03-13-154205.png")
benoit = User.create(username: "Ecoben", email: "benoit@wagon.com", password: "123456", xp: 88300, wheel: Time.now - 60 * 60 * 24 , seriestart: Time.now - 60 * 60 * 24 * 33, seriecurrent: Time.now, order: 197 )
benoit.photo.attach(io: fileBenoit, filename: "Capture-d-cran-2024-03-13-154205.png", content_type: "image/png")
benoit.save

# profil 4
fileStephane = URI.open("https://i.ibb.co/M6M1N7H/Capture-d-cran-2024-03-13-153416.png")
stephane = User.create(username: "stephane", email: "stephane@wagon.com", password: "123456", xp: 62600, wheel: Time.now - 60 * 60 * 24, seriestart: Time.now - 60 * 60 * 24 * 16, seriecurrent: Time.now, order: 130 )
stephane.photo.attach(io: fileStephane, filename: "Capture-d-cran-2024-03-13-153416.png", content_type: "image/png")
stephane.save

# profil 5
fileSeb = URI.open("https://i.ibb.co/pPktGQv/seb.png")
seb = User.create(username: "sebdu33", email: "sebdu33@wagon.com", password: "123456", xp: 7450, wheel: Time.now - 60 * 60 * 24, seriestart: Time.now - 60, seriecurrent: Time.now, order: 18 )
seb.photo.attach(io: fileSeb, filename: "seb.png", content_type: "image/png")
seb.save

# profil 6
fileAnne = URI.open("https://i.ibb.co/MPgqNdQ/anne.png")
anne = User.create(username: "AnneGrand", email: "annegrand@wagon.com", password: "123456", xp: 22300,  wheel: Time.now - 60 * 60 * 24, seriestart: Time.now - 60, seriecurrent: Time.now , order: 55)
anne.photo.attach(io: fileAnne, filename: "anne.png", content_type: "image/png")
anne.save

# profil 7
fileJohnDoe = URI.open("https://i.ibb.co/P4kmNd3/john.png")
john = User.create(username: "JohnDoe", email: "johndoe@wagon.com", password: "123456", xp: 31850,  wheel: Time.now - 60 * 60 * 24, seriestart: Time.now - 60 * 60 * 24 * 40, seriecurrent: Time.now, order: 79 )
john.photo.attach(io: fileJohnDoe, filename: "john.png", content_type: "image/png")
john.save

# profil 8
fileAlain = URI.open("https://i.ibb.co/923DKMf/alain.png")
alain = User.create(username: "alainproviste", email: "alainproviste@wagon.com", password: "123456", xp: 14700,  wheel: Time.now - 60 * 60 * 24, seriestart: Time.now - 60 * 60 * 24 * 2, seriecurrent: Time.now, order: 36 )
alain.photo.attach(io: fileAlain, filename: "alain.png", content_type: "image/Png")
alain.save

# profil 9
fileEric = URI.open("https://i.ibb.co/WxQxsJP/eric.png")
eric = User.create(username: "EricTeslaPassion", email: "ericteslapassion@wagon.com", password: "123456", xp: 51200,  wheel: Time.now - 60 * 60 * 24, seriestart: Time.now - 60 * 60 * 24 * 26, seriecurrent: Time.now, order: 121 )
eric.photo.attach(io: fileEric, filename: "eric.png", content_type: "image/png")
eric.save

# profil 10
fileUrban = URI.open("https://i.ibb.co/rdfD2dw/urbannomad.png")
urban = User.create(username: "UrbanNomad", email: "urbannomad@wagon.com", password: "123456", xp: 26450,  wheel: Time.now - 60 * 60 * 24, seriestart: Time.now - 60 * 60 * 24 * 16, seriecurrent: Time.now, order: 58 )
urban.photo.attach(io: fileUrban, filename: "urbannomad.png", content_type: "image.png")
urban.save
