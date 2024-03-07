class Vehicle < ApplicationRecord
  belongs_to :user
  has_many :bookings
  validates :brand, presence: true
  validates :model, presence: true

  # Liste de tout les vehicules
  cattr_reader :car_list
  @@car_list = {
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

  def self.car_list
    @@car_list
  end

  def self.all_car_models
    @@car_list.each do |brand, details|
      models = details["Modeles"]
    end
  end

end

