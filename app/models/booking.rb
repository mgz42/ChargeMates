class Booking < ApplicationRecord
  belongs_to :vehicle
  belongs_to :station
  has_many :messages, dependent: :destroy
  has_many :conflicts

  # Calculer la durée de la réservation en heures
  def duree_recharge_heures
    return 0 unless date_heure_fin_de_reservation && date_heure_reservation
    ((date_heure_fin_de_reservation - date_heure_reservation) / 1.hour).round(2)
  end

  # Calculer les kilowatts-heure consommés pendant la recharge, basé sur la durée et la puissance maximale de recharge
  def kw_h_consommes
      # Puissance maximale que la station peut délivrer
      puissance_station = station.max_kW_recharge || 0
      # Puissance maximale de recharge que le véhicule peut accepter
      puissance_vehicule = vehicle.puissance_maximale_recharge || 0
      # Utiliser le minimum entre la puissance de la station et celle du véhicule
      puissance_effective = [puissance_station, puissance_vehicule].min

      capacite_batterie = vehicle.capacite_batterie
      # Calculer l'énergie potentielle basée sur la durée et la puissance effective
      energie_potentielle = duree_recharge_heures * puissance_effective
      # Limiter l'énergie consommée à la capacité de la batterie du véhicule
      energie_consommee = [energie_potentielle, capacite_batterie].min

      energie_consommee.round(1)
  end

  # Calculer le pourcentage de la batterie rechargée
  def pourcentage_batterie
    capacite_batterie = vehicle.capacite_batterie # Utilisation de la méthode capacite_batterie du modèle Vehicle
    energie_consommee_kwh = kw_h_consommes # Utilise la méthode kw_h_consommes qui prend déjà en compte la capacité maximale
    pourcentage = capacite_batterie > 0 ? (energie_consommee_kwh / capacite_batterie.to_f * 100) : 0
    pourcentage.round(1)
  end

  # Calculer le prix total de la recharge
  def prix_total_recharge
    prix_par_kwh = 0.23 # Prix par kWh en euros
    prix_base_stationnement = 3 # Prix de base pour le stationnement
    energie_consommee_kwh = kw_h_consommes

    (energie_consommee_kwh * prix_par_kwh + prix_base_stationnement).round(2)
  end
end
