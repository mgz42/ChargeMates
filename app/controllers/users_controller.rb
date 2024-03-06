class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @users = User.all # ou toute autre logique pour récupérer les utilisateurs
    current_user_rank = @users.order(xp: :desc).pluck(:id).index(current_user.id).to_i + 1
    @current_user_rank = current_user_rank
    @total_users_count = @users.count
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "Votre profil a été mis à jour avec succès."
    else
      render :show
    end
  end

  def leaderboard
    @users = User.order(xp: :desc)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :xp)
  end

end
