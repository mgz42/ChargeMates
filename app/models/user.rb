class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :vehicles
  has_many :badges
  has_one :station
  has_many :messages
  has_many :conflicts
  has_many :bookings



  # Définir les colonnes de votre table users dans le modèle
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :username, presence: true
  validates :xp, presence: true

  # Si vous souhaitez un format spécifique pour le nom d'utilisateur, vous pouvez ajouter des validations supplémentaires
  # Par exemple, pour s'assurer qu'il contient uniquement des lettres, des chiffres et des caractères spéciaux "-" et "_"
  # validates :username, format: { with: /\A[a-zA-Z0-9_-]+\z/, message: "ne peut contenir que des lettres, des chiffres, - et _" }
  def avatar_url
    if avatar_url.present?
      avatar_url
    else
      # URL par défaut pour une image grise
      "https://via.placeholder.com/150?text=No+Avatar&bg=CCCCCC&fg=000000"
    end
  end
end
