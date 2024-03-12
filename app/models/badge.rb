class Badge < ApplicationRecord
  belongs_to :user

  # Liste de tout les badges
  cattr_reader :badge_list, :badge_img, :f, :m
  @@badge_list = [
    {name: "niveau_un", xp: 25000, level: 25},
    {name: "niveau_deux", xp: 50000, level: 50},
    {name: "niveau_trois", xp: 75000, level: 75},
    {name: "niveau_quatre", xp: 100000, level: 100},

    # nom des badges secondaires + leur duree (24h, 1 semaine ou instantané si pas indiqué)

    {name: "freeze_week", duree: "two weeks"}, # freeze la serie pendant deux semaines
    {name: "freeze_month", duree: "month"}, # freeze la serie pendant un mois
    {name: "minus_one_euro"},             # 1 euro de reduction sur la place parking pour la prochaine commande
    {name: "double_xp", duree: "day"}, # double l'XP gagné pendant un jour
    {name: "level_up"},# ajoute de l'XP a l'user pour lui faire gagner un level (donc arrondi de l'xp user au multiple de 1000 suivant)

    # ci dessous badges purement esthetique(badge feuille de cristal et badge esthetique de la semaine)

    {name: "cristal", duree: "day"},
    {name: "weekly_special", duree: "week"},
  ]
  @@badge_img = { "freeze_week" => "https://i.ibb.co/4TZ6ZHC/freeze.png", "freeze_month" => "https://i.ibb.co/x6D3pWX/freeze-month.png",
                  "minus_one_euro" =>  "https://i.ibb.co/GsJnyG0/moin-euro.png", "double_xp" => "https://i.ibb.co/vmLBNRb/2xp.png",
                  "level_up" => "https://i.ibb.co/BBmhSgS/lv1.png", "cristal" => "https://i.ibb.co/ySR293h/cristal.png",
                  "weekly_special" => "https://i.ibb.co/HTW0v1G/weekly-sp.png"}
  @@f = ["https://i.ibb.co/y4SfF2r/lv-1.png", "https://i.ibb.co/TPT4p6Y/lv2.png", "https://i.ibb.co/ygm2Yds/lv-3.png",
    "https://i.ibb.co/GTSzwnn/lv-4.png"]

  @@m = ["https://i.ibb.co/YZZ338N/feuille-lv-1.png","https://i.ibb.co/cLD0sj5/feuille-lv-2.png","https://i.ibb.co/9NdHDMj/feuille-lv-3.png",
  "https://i.ibb.co/g38pxhM/feuille-lv-4-copie.png","https://i.ibb.co/QXb0254/Sans-titre-1.png"]
end
