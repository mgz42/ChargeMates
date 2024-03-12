class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action do
    current_user.badges.each do |badge|
      if badge.duration < Time.now
        badge.destroy
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

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
    # date = user_params[:wheel].to_time
    if @user.update(wheel: Time.now)
    else
      render :show
    end
  end

  def leaderboard
    @users = User.order(xp: :desc)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :xp, :wheel, :photo)
  end

end
