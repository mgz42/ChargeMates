class Badge < ApplicationRecord
  belongs_to :user

  # Liste de tout les badges
  cattr_reader :badge_list
  @@badge_list = [
    {name: "niveau_un", xp: 25000, level: 25},
    {name: "niveau_deux", xp: 50000, level: 50},
    {name: "niveau_trois", xp: 75000, level: 75},
    {name: "niveau_quatre", xp: 100000, level: 100},

    # nom des badges secondaires + leur duree (24h, 1 semaine ou instantané si pas indiqué)

    {name: "freeze_week", duree: "two weeks"}, # freeze la serie pendant deux semaines
    {name: "freeze_month", duree: "month"}, # freeze la serie pendant un mois
    {name: "minus_one_euro"},             # 1 euro de reduction sur la place parking pour la prochaine commande
    {name: "double_xp", duree: "day" }, # double l'XP gagné pendant un jour
    {name: "level_up"},                 # ajoute de l'XP a l'user pour lui faire gagner un level (donc arrondi de l'xp user au multiple de 1000 suivant)

    # ci dessous badges purement esthetique(badge feuille de cristal et badge esthetique de la semaine)

    {name: "cristal", duree: "day"},
    {name: "weekly_special", duree: "week"},
  ]
end
