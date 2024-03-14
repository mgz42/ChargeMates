class Booking < ApplicationRecord
  belongs_to :vehicle
  belongs_to :station
  has_many :messages, dependent: :destroy
  has_many :conflicts, dependent: :destroy
  before_create :set_default_status
  has_one :user, through: :vehicle
  has_one :station_owner, through: :station, source: :user



  enum status: {
    en_attente_de_soumission: 'en_attente_de_soumission',
    en_attente_de_confirmation: 'en_attente_de_confirmation',
    en_attente_de_validation: 'en_attente_de_validation',
    en_attente_de_paiement: 'en_attente_de_paiement',
    en_attente_de_charge: 'en_attente_de_charge',
    en_charge: 'en_charge',
    termine: 'termine'
  }

  def en_attente_de_confirmation?
    status == 'en_attente_de_confirmation'
  end

  def en_attente_de_soumission?
    status == 'en_attente_de_soumission'
  end

  def en_attente_de_validation?
    status == 'en_attente_de_validation'
  end

  def en_attente_de_paiement?
    status == 'en_attente_de_paiement'
  end

  def en_attente_de_charge?
    status == 'en_attente_de_charge'
  end

  def en_charge?
    status == 'en_charge'
  end

  def termine?
    status == 'termine'
  end

  def initier_offre!
    update(status: :en_attente_de_confirmation)
  end

  def confirmer_offre!
    update(status: :en_attente_de_soumission)
  end

  def soumettre_offre!
    update(status: :en_attente_de_validation)
    created_message = messages.create(content: "🤖 Message bot: Bonjour👋, je souhaite venir recharger ma voiture le #{date_heure_reservation.strftime('%d/%m/%Y')} à #{date_heure_reservation.strftime('%H:%M')}.", user: vehicle.user)
    refresh_tchat(created_message)
  end

  def accepter_offre!
    update(status: :en_attente_de_paiement)
    created_message = messages.create(content: "🤖 Message bot: Bonjour👋, votre demande est acceptée. La place est disponible pour le #{date_heure_reservation.strftime('%d/%m/%Y')} à #{date_heure_reservation.strftime('%H:%M')}.", user: station.user)
    refresh_tchat(created_message)
  end

  def refuser_offre!
    update(status: :termine)
    created_message = messages.create(content: "🤖 Message bot: Bonjour, 🫣 oups je ne serais pas disponible.", user: station.user)
    refresh_tchat(created_message)
  end

  def valider_paiement!
    update(status: :en_attente_de_charge)
    message_paiement = messages.create(content: "🤖 Message bot: ✅ Paiement effectué le #{Time.zone.now.strftime('%d/%m/%Y à %H:%M')}", user: vehicle.user)
    message_comment_supply = messages.create(content: "🤖 Message bot: #{station.comment_supply}", user: station.user)
    refresh_tchat(message_paiement)

  end

  def commencer_charge!
    update(status: :en_charge, date_heure_debut_recharge: Time.current)
    created_message = messages.create(content: "🤖 Message bot: 🔌 Mon véhicule est en charge", user: vehicle.user)
    refresh_tchat(created_message)
  end

  def terminer_charge!
    update(status: :termine, date_heure_fin_recharge: Time.current)
    duration = recharge_duration
    kwh = kw_h_consommes_reel
    percentage = pourcentage_batterie_reel
    created_message = messages.create(content: "🤖 Message bot: 🔋 J'ai fini de recharger mon véhicule, j'ai rechargé #{duration} heures, environ #{kwh} kW/h ce qui représente #{percentage}% de ma batterie, Merci ChargeMate!", user: vehicle.user)
    refresh_tchat(created_message)
  end


  def recharge_duration
    return 0 unless date_heure_debut_recharge && date_heure_fin_recharge

    ((date_heure_fin_recharge - date_heure_debut_recharge) / 1.hour).round(2)
  end

  def kw_h_consommes_reel
    puissance_station = station.max_kW_recharge || 0
    puissance_vehicule = vehicle.puissance_maximale_recharge || 0
    puissance_effective = [puissance_station, puissance_vehicule].min
    capacite_batterie = vehicle.capacite_batterie
    energie_potentielle = recharge_duration * puissance_effective
    energie_consommee = [energie_potentielle, capacite_batterie].min
    energie_consommee.round(1)
  end

  def pourcentage_batterie_reel
    capacite_batterie = vehicle.capacite_batterie
    energie_consommee_kwh = kw_h_consommes_reel
    pourcentage = capacite_batterie > 0 ? (energie_consommee_kwh / capacite_batterie.to_f * 100) : 0
    pourcentage.round(1)
  end

  def duree_recharge_heures
    return 0 unless date_heure_fin_de_reservation && date_heure_reservation

    ((date_heure_fin_de_reservation - date_heure_reservation) / 1.hour).round(2)
  end

  def kw_h_consommes_reservation
    puissance_station = station.max_kW_recharge || 0
    puissance_vehicule = vehicle.puissance_maximale_recharge || 0
    puissance_effective = [puissance_station, puissance_vehicule].min
    capacite_batterie = vehicle.capacite_batterie
    energie_potentielle = duree_recharge_heures * puissance_effective
    energie_consommee = [energie_potentielle, capacite_batterie].min
    energie_consommee.round(1)
  end

  def pourcentage_batterie_reservation
    capacite_batterie = vehicle.capacite_batterie
    energie_consommee_kwh = kw_h_consommes_reservation
    pourcentage = capacite_batterie > 0 ? (energie_consommee_kwh / capacite_batterie.to_f * 100) : 0
    pourcentage.round(1)
  end

  def prix_total_recharge
    prix_par_kwh = 0.23
    prix_base_stationnement = 3
    energie_consommee_kwh = kw_h_consommes_reservation
    (energie_consommee_kwh * prix_par_kwh + prix_base_stationnement).round(2)
  end

  private

  def refresh_tchat(message)
    TchatMateChannel.broadcast_to(
      self,
      ApplicationController.render(partial: 'messages/messagelist', locals: { booking: self })
    )
  end

  def set_default_status
    self.status ||= 'en_attente_de_soumission'
  end

end
