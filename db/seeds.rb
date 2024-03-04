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
voitures_electriques = {
  'Tesla' => {
    'Modeles' => ['Model S', 'Model 3', 'Model X', 'Model Y'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 250
  },
  'Nissan' => {
    'Modeles' => ['Leaf'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 50
  },
  'Chevrolet' => {
    'Modeles' => ['Bolt EV'],
    'Type_prise' => 'CCS Combo',
    'Puissance_maximale_recharge' => 55
  },
  'BMW' => {
    'Modeles' => ['i3', 'iX3', 'i4', 'iX'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 150
  },
  'Audi' => {
    'Modeles' => ['e-tron', 'e-tron Sportback'],
    'Type_prise' => 'CCS Combo',
    'Puissance_maximale_recharge' => 150
  },
  'Hyundai' => {
    'Modeles' => ['Kona Electric', 'Ioniq Electric'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 100
  },
  'Kia' => {
    'Modeles' => ['Soul EV', 'Niro EV'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 100
  },
  'Renault' => {
    'Modeles' => ['Zoe', 'Twingo Electric', 'Kangoo Z.E.'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 22
  },
  'Mercedes-Benz' => {
    'Modeles' => ['EQC'],
    'Type_prise' => 'CCS Combo',
    'Puissance_maximale_recharge' => 110
  },
  'Porsche' => {
    'Modeles' => ['Taycan'],
    'Type_prise' => 'CCS Combo',
    'Puissance_maximale_recharge' => 270
  },
  'Ford' => {
    'Modeles' => ['Mustang Mach-E'],
    'Type_prise' => 'CCS Combo',
    'Puissance_maximale_recharge' => 150
  },
  'Jaguar' => {
    'Modeles' => ['I-Pace'],
    'Type_prise' => 'CCS Combo',
    'Puissance_maximale_recharge' => 100
  },
  'Mini' => {
    'Modeles' => ['Mini Electric'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 50
  },
  'Honda' => {
    'Modeles' => ['Honda e'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 50
  },
  'Mitsubishi' => {
    'Modeles' => ['Outlander PHEV'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 3.7
  },
  'Smart' => {
    'Modeles' => ['EQ Fortwo', 'EQ Forfour'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 22
  },
  'Fiat' => {
    'Modeles' => ['500e'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 85
  },
  'Mazda' => {
    'Modeles' => ['Atenza e-TPV'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 6.6
  },
  'MG' => {
    'Modeles' => ['ZS EV', 'MG5 EV'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 50
  },
  'Opel/Vauxhall' => {
    'Modeles' => ['Corsa-e', 'Mokka-e'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 100
  },
  'DS Automobiles' => {
    'Modeles' => ['DS 3 Crossback E-Tense', 'DS 7 Crossback E-Tense'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 100
  },
  'Citroën' => {
    'Modeles' => ['C-Zero', 'e-C4', 'e-SpaceTourer'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 100
  },
  'Peugeot' => {
    'Modeles' => ['e-208', 'e-2008', 'e-Traveller'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 100
  },
  'SEAT' => {
    'Modeles' => ['Mii Electric', 'el-Born'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 100
  },
  'Skoda' => {
    'Modeles' => ['CITIGOe iV', 'ENYAQ iV'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 125
  },
  'Lexus' => {
    'Modeles' => ['UX 300e'],
    'Type_prise' => 'Type 2',
    'Puissance_maximale_recharge' => 50
  }
}

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

User.create(username: "marine", email: "marine@wagon.com", password: "123456", xp: 1200)
User.create(username: "honorine", email: "honorine@wagon.com", password: "123456", xp: 3420)
User.create(username: "benoit", email: "benoit@wagon.com", password: "123456", xp: 850)
User.create(username: "stephane", email: "stephane@wagon.com", password: "123456", xp: 9700)

Vehicle.create(brand: "Hyundai", model: "Kona Electric", plug: "Type 2", max_kW_recharge: 100, immatriculation: "2YUCK98", model_year: 2022, user_id: User.first.id )
Vehicle.create(brand: "Lexus", model: "UX 300e", plug: "Type 2", max_kW_recharge: 50, immatriculation: "6UYGK98", model_year: 2021, user_id: User.first.id )

Vehicle.create(brand: "Nissan", model: "Leaf", plug: "Type 2", max_kW_recharge: 50, immatriculation: "98HGK98", model_year: 2023, user_id: User.second.id )

Vehicle.create(brand: "Porsche", model: "Taycan", plug: "CCS Combo", max_kW_recharge: 270, immatriculation: "UI22GK9", model_year: 2022, user_id: User.third.id )

Vehicle.create(brand: "Tesla", model: "Model X", plug: "Type 2", max_kW_recharge: 250, immatriculation: "F34HGK9", model_year: 2023, user_id: User.fourth.id )
Vehicle.create(brand: "Jaguar", model: "I-Pace", plug: "CCS Combo", max_kW_recharge: 100, immatriculation: "724FGK9", model_year: 2023, user_id: User.fourth.id )

Station.create(address: "63, Rue Malbec, Saint-Jean, Bordeaux Sud, Bordeaux, Gironde, Nouvelle-Aquitaine, France métropolitaine, 33800, France", latitude: 44.82592, longitude: -0.56233, plug: "Type 2", brand: "Wallbox", model: "Pulsar", parking_price: 3, consomation_price: 3.5, max_kW_recharge: 22, available: true, code_station: 1234, user_id: User.first.id )
Station.create(address: "55, Rue Giacomo Matteotti, La Benauge, La Bastide, Bordeaux, Gironde, Nouvelle-Aquitaine, France métropolitaine, 33100, France", latitude: 44.83248, longitude: -0.54329, plug: "Type 2", brand: "Walker", model: "UP-3", parking_price: 3, consomation_price: 4.3, max_kW_recharge: 22, available: true, code_station: 1234, user_id: User.second.id )
Station.create(address: "138, Rue Carle Vernet, Belcier, Bordeaux Sud, Bordeaux, Gironde, Nouvelle-Aquitaine, France métropolitaine, 33800, France", latitude: 44.81803, longitude: -0.55285, plug: "CSS Combo", brand: "Wallbox", model: "Soleil", parking_price: 3, consomation_price: 5.5, max_kW_recharge: 270, available: true, code_station: 1234, user_id: User.third.id )
Station.create(address: "9, Rue Carpenteyre, Saint-Michel, Bordeaux Sud, Bordeaux, Gironde, Nouvelle-Aquitaine, France métropolitaine, 33800, France", latitude: 44.83428, longitude: -0.56403, plug: "CSS Combo", brand: "Wallbox", model: "Pulsar", parking_price: 3, consomation_price: 4.3, max_kW_recharge: 250, available: true, code_station: 1234, user_id: User.fourth.id )

#booking honorine
Booking.create(vehicle_id: 3, station_id: Station.first.id, date_heure_reservation: "20240304140020", date_heure_debut_recharge: "20240304140520", duree_recharge: 2.5 , date_heure_fin_recharge: "20240304170020" , status: "termine" )
Booking.create(vehicle_id: 1, station_id: Station.second.id, date_heure_reservation: "20240304140020",date_heure_debut_recharge: "20240304140520", duree_recharge: 2.5, date_heure_fin_recharge: "20240304170020", status: "termine" )

#booking benoit
Booking.create(vehicle_id: 4, station_id: Station.fourth.id, date_heure_reservation: "20240304140020",date_heure_debut_recharge: "20240304140520" , duree_recharge: 2.5, date_heure_fin_recharge: "20240304170020", status: "termine" )
Booking.create(vehicle_id: 6, station_id: Station.third.id, date_heure_reservation: "20240304140020",date_heure_debut_recharge: "20240304140520", duree_recharge: 2.5, date_heure_fin_recharge: "20240304170020", status: "termine" )

#booking stephane
Booking.create(vehicle_id: 5, station_id: Station.second.id, date_heure_reservation: "20240304140020",date_heure_debut_recharge: "20240304140520", duree_recharge: 2.5, date_heure_fin_recharge: "20240304170020", status: "termine" )
