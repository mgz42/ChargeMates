class BadgesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    Badge.badge_list.each do |badge|
      if badge["name"] == badge_params[:name]
        if badge["duree"]
          duree = badge["duree"]
        else
          duree = 0
        end
      end
    end

    if duree != 0
      if duree == "day"
        duration = Time.now + 60 * 60 * 24
      elsif duree == "week"
        duration = Time.now + 60 * 60 * 24 * 7
      elsif duree == "two weeks"
        duration = Time.now + 60 * 60 * 24 * 14
      elsif duree == "month"
        duration = Time.now + 60 * 60 * 24 * 30
      end
    else
      duration = Time.now
    end

    @user = current_user
    @badge = Badge.new(badge_params)
    @badge.user_id = @user.id
    @bagde.duration = duration
    @badge.image = Badge.badge_list[]
    @badge.save
  end


  def destroy

  end

private

  def badge_params
    params.require(:badge).permit(:name)
  end
end
