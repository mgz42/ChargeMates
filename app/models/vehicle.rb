class Vehicle < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  validates :brand, presence: true
  validates :model, presence: true

  # Liste de tout les vehicules
  cattr_reader :car_list
  @@car_list = {
    'Tesla' => {
      'Modeles' => ['Model S', 'Model 3', 'Model X', 'Model Y'],
      'Type_prise' => 'CSS Combo',
      'Puissance_maximale_recharge' => 250,
      'capacite' => 90,
      'Logo_url' => 'https://i.ibb.co/3z3Xfbv/Tesla-logo.png',
      'Logo_prise_url' => 'https://i.ibb.co/3CnMLK8/CSSCombo.png'

    },
    'Nissan' => {
      'Modeles' => ['Leaf', 'Leaf 2'],
      'Type_prise' => 'Type 2',
      'Puissance_maximale_recharge' => 50,
      'capacite' => 42,
      'Logo_url' => 'https://i.ibb.co/CwcBw53/nissan.png',
      'Logo_prise_url' => 'https://i.ibb.co/KzVtFBG/type2.png'
    },
    'Chevrolet' => {
      'Modeles' => ['Bolt EV'],
      'Type_prise' => 'CCS Combo',
      'Puissance_maximale_recharge' => 55,
      'capacite' => 50,
      'Logo_url' => 'https://i.ibb.co/CmcZJs9/Chevrolet-Logo.png',
      'Logo_prise_url' => 'https://i.ibb.co/3CnMLK8/CSSCombo.png'
    },
    'BMW' => {
      'Modeles' => ['i3', 'iX3', 'i4', 'iX', 'i8'],
      'Type_prise' => 'Type 2',
      'Puissance_maximale_recharge' => 150,
      'capacite' => 70,
      'Logo_url' => 'https://i.ibb.co/QkGkHCh/bmw.png',
      'Logo_prise_url' => 'https://i.ibb.co/KzVtFBG/type2.png'
    },
    'Audi' => {
      'Modeles' => ['e-tron', 'e-tron Sportback'],
      'Type_prise' => 'CCS Combo',
      'Puissance_maximale_recharge' => 150,
      'capacite' => 70,
      'Logo_url' => 'https://i.ibb.co/z5FHj9t/audi.png',
      'Logo_prise_url' => 'https://i.ibb.co/3CnMLK8/CSSCombo.png'
    },
    'Hyundai' => {
      'Modeles' => ['Kona Electric', 'Ioniq Electric'],
      'Type_prise' => 'Type 2',
      'Puissance_maximale_recharge' => 100,
      'capacite' => 50,
      'Logo_url' => 'https://i.ibb.co/NZ54nh0/hyundai.png',
      'Logo_prise_url' => 'https://i.ibb.co/KzVtFBG/type2.png'
    },
    'Kia' => {
      'Modeles' => ['Soul EV', 'Niro EV'],
      'Type_prise' => 'Type 2',
      'Puissance_maximale_recharge' => 100,
      'capacite' => 40,
      'Logo_url' => 'https://i.ibb.co/wKG78H2/kia.png',
      'Logo_prise_url' => 'https://i.ibb.co/KzVtFBG/type2.png'
    },
    'Renault' => {
      'Modeles' => ['Zoe', 'Twingo Electric', 'Kangoo Z.E.'],
      'Type_prise' => 'Type 2',
      'Puissance_maximale_recharge' => 22,
      'capacite' => 45,
      'Logo_url' => 'https://i.ibb.co/wS2R9bF/renault.png',
      'Logo_prise_url' => 'https://i.ibb.co/KzVtFBG/type2.png'
    },
    'Mercedes-Benz' => {
      'Modeles' => ['EQC'],
      'Type_prise' => 'CCS Combo',
      'Puissance_maximale_recharge' => 110,
      'capacite' => 80,
      'Logo_url' => 'https://i.ibb.co/Y7Z4FBT/mercedes.png',
      'Logo_prise_url' => 'https://i.ibb.co/3CnMLK8/CSSCombo.png'
    },
    'Porsche' => {
      'Modeles' => ['Taycan'],
      'Type_prise' => 'CCS Combo',
      'Puissance_maximale_recharge' => 270,
      'capacite' => 95,
      'Logo_url' => 'https://i.ibb.co/6yZvm9G/porsche.png',
      'Logo_prise_url' => 'https://i.ibb.co/3CnMLK8/CSSCombo.png'
    },
    'Ford' => {
      'Modeles' => ['Mustang Mach-E'],
      'Type_prise' => 'CCS Combo',
      'Puissance_maximale_recharge' => 150,
      'capacite' => 13.6,
      'Logo_url' => 'https://i.ibb.co/25Q9PCZ/ford.png',
      'Logo_prise_url' => 'https://i.ibb.co/3CnMLK8/CSSCombo.png'
    },
    'Jaguar' => {
      'Modeles' => ['I-Pace'],
      'Type_prise' => 'CCS Combo',
      'Puissance_maximale_recharge' => 100,
      'capacite' => 90,
      'Logo_url' => 'https://i.ibb.co/9nCG9Bn/Jaguar.png',
      'Logo_prise_url' => 'https://i.ibb.co/3CnMLK8/CSSCombo.png'
    },
    'Mini' => {
      'Modeles' => ['Mini Electric'],
      'Type_prise' => 'Type 2',
      'Puissance_maximale_recharge' => 50,
      'capacite' => 35,
      'Logo_url' => 'https://i.ibb.co/yqzbNQ6/mini.png',
      'Logo_prise_url' => 'https://i.ibb.co/KzVtFBG/type2.png'
    },
    'Honda' => {
      'Modeles' => ['Honda e'],
      'Type_prise' => 'Type 2',
      'Puissance_maximale_recharge' => 50,
      'capacite' => 40,
      'Logo_url' => 'https://i.ibb.co/2ZkGGBw/honda.png',
      'Logo_prise_url' => 'https://i.ibb.co/KzVtFBG/type2.png'
    },
    'Mitsubishi' => {
      'Modeles' => ['Outlander PHEV'],
      'Type_prise' => 'Type 2',
      'Puissance_maximale_recharge' => 3.7,
      'capacite' => 12,
      'Logo_url' => 'https://i.ibb.co/2FdPHPt/mitsubishi.png',
      'Logo_prise_url' => 'https://i.ibb.co/KzVtFBG/type2.png'
    },
    'Smart' => {
      'Modeles' => ['EQ Fortwo', 'EQ Forfour'],
      'Type_prise' => 'Type 2',
      'Puissance_maximale_recharge' => 22,
      'capacite' => 17.6,
      'Logo_url' => 'https://i.ibb.co/QdzDMrW/smart.png',
      'Logo_prise_url' => 'https://i.ibb.co/KzVtFBG/type2.png'
    },
    'Fiat' => {
      'Modeles' => ['500e'],
      'Type_prise' => 'Type 2',
      'Puissance_maximale_recharge' => 85,
      'capacite' => 35,
      'Logo_url' => 'https://i.ibb.co/ZhQ7N6X/fiat.png',
      'Logo_prise_url' => 'https://i.ibb.co/KzVtFBG/type2.png'
    },
    'Mazda' => {
      'Modeles' => ['Atenza e-TPV'],
      'Type_prise' => 'Type 2',
      'Puissance_maximale_recharge' => 6.6,
      'capacite' => 0.8,
      'Logo_url' => 'https://i.ibb.co/BTQ3prP/mazda.png',
      'Logo_prise_url' => 'https://i.ibb.co/KzVtFBG/type2.png'
    },
    'MG' => {
      'Modeles' => ['ZS EV', 'MG5 EV'],
      'Type_prise' => 'Type 2',
      'Puissance_maximale_recharge' => 50,
      'capacite' => 51,
      'Logo_url' => 'https://i.ibb.co/mFSLSgs/mg.png',
      'Logo_prise_url' => 'https://i.ibb.co/KzVtFBG/type2.png'
    },
    'Opel/Vauxhall' => {
      'Modeles' => ['Corsa-e', 'Mokka-e'],
      'Type_prise' => 'Type 2',
      'Puissance_maximale_recharge' => 100,
      'capacite' => 50,
      'Logo_url' => 'https://i.ibb.co/DrX0hzc/Opel.png',
      'Logo_prise_url' => 'https://i.ibb.co/KzVtFBG/type2.png'
    },
    'DS Automobiles' => {
      'Modeles' => ['DS 3 Crossback E-Tense', 'DS 7 Crossback E-Tense'],
      'Type_prise' => 'Type 2',
      'Puissance_maximale_recharge' => 100,
      'capacite' => 13.2,
      'Logo_url' => 'https://i.ibb.co/DrX0hzc/Opel.png',
      'Logo_prise_url' => 'https://i.ibb.co/KzVtFBG/type2.png'
    },
    'Citroën' => {
      'Modeles' => ['C-Zero', 'e-C4', 'e-SpaceTourer'],
      'Type_prise' => 'Type 2',
      'Puissance_maximale_recharge' => 100,
      'capacite' => 13.2,
      'Logo_url' => 'https://i.ibb.co/m4zWWwv/citroen.png',
      'Logo_prise_url' => 'https://i.ibb.co/KzVtFBG/type2.png'
    },
    'Peugeot' => {
      'Modeles' => ['e-208', 'e-2008', 'e-Traveller'],
      'Type_prise' => 'Type 2',
      'Puissance_maximale_recharge' => 100,
      'capacite' => 50,
      'Logo_url' => 'https://i.ibb.co/7jqTqkx/peugeot.png',
      'Logo_prise_url' => 'https://i.ibb.co/KzVtFBG/type2.png'
    },
    'SEAT' => {
      'Modeles' => ['Mii Electric', 'el-Born'],
      'Type_prise' => 'Type 2',
      'Puissance_maximale_recharge' => 100,
      'capacite' => 5.6,
      'Logo_url' => 'https://i.ibb.co/VHhc7Tf/seat.png',
      'Logo_prise_url' => 'https://i.ibb.co/KzVtFBG/type2.png'
    },
    'Skoda' => {
      'Modeles' => ['CITIGOe iV', 'ENYAQ iV'],
      'Type_prise' => 'Type 2',
      'Puissance_maximale_recharge' => 125,
      'capacite' => 72,
      'Logo_url' => 'https://i.ibb.co/r2t9FDb/skoda.png',
      'Logo_prise_url' => 'https://i.ibb.co/KzVtFBG/type2.png'
    },
    'Lexus' => {
      'Modeles' => ['UX 300e'],
      'Type_prise' => 'Type 2',
      'Puissance_maximale_recharge' => 50,
      'capacite' => 9.5,
      'Logo_url' => 'https://i.ibb.co/KGWy1dP/lexus.png',
      'Logo_prise_url' => 'https://i.ibb.co/KzVtFBG/type2.png'
    }
  }
#   def self.car_list
#     @@car_list
#   end

  def self.all_car_models
    @@car_list.each do |brand, details|
      models = details["Modeles"]
    end
  end
end
