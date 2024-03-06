class UpdateBookingsUserId < ActiveRecord::Migration[7.1]
  def up
    Booking.where(user_id: nil).each do |booking|
      # Assurez-vous de remplacer `User.first.id` par la méthode appropriée
      # pour obtenir l'ID de l'utilisateur que vous souhaitez attribuer à ces réservations.
      booking.update(user_id: User.first.id)
    end
  end

  def down
    # Si vous avez besoin d'une méthode down, vous pouvez l'implémenter ici.
    # Cela peut être nécessaire si vous prévoyez de revenir en arrière
    # sur cette migration à l'avenir.
  end
end

