class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def show
    @users = User.all # ou toute autre logique pour récupérer les utilisateurs
    current_user_rank = @users.order(xp: :desc).pluck(:id).index(current_user.id).to_i + 1
    @current_user_rank = current_user_rank
    @total_users_count = @users.count

    user_vehicles = current_user.vehicles
    user_station = current_user.station
    if current_user.station
      @bookings = Booking.where(vehicle_id: user_vehicles.ids).or(Booking.where(station_id: user_station.id)).order('created_at DESC')
    else
      @bookings = Booking.where(vehicle_id: user_vehicles.ids).order('created_at DESC')
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      # Il faut redirect to user seulement si la requete ne vient pas d'Ajax
      redirect_to @user
    else
      render :show
    end
  end

  def leaderboard
    @users = User.order(xp: :desc)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :xp, :wheel)
  end

end
