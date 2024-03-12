class BadgesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    duree = ""
    Badge.badge_list.each do |badge|
      if badge[:name] == badge_params[:name]
          duree = badge[:duree]
      end
    end

    if duree != 0
      if duree == "day"
        duration = Time.now + 60 * 60 * 24
      elsif duree == "2day"
        duration = Time.now + 60 * 60 * 24 * 2
      elsif duree == "week"
        duration = Time.now + 60 * 60 * 24 * 7
      elsif duree == "two weeks"
        duration = Time.now + 60 * 60 * 24 * 14
      elsif duree == "month"
        duration = Time.now + 60 * 60 * 24 * 30
      elsif duree == "year"
        duration = Time.now + 60 * 60 * 24 * 365
      end
    else
      duration = ""
    end

    @user = current_user

    isnew = true
    @user.badges.each do |badge|
      if badge.name == badge_params[:name]
        if badge.update(duration: duration)
          xps = ((@user.xp.to_f + 1) / 1000).ceil * 1000 if badge_params[:name] == "level_up"
          xps = @user.xp + 500 if badge_params[:name] == "cristal"
          @user.update(xp: xps) if (badge_params[:name] == "cristal" || badge_params[:name] == "level_up")
        end
        isnew = false
      end
    end

    if isnew == true
      @badge = Badge.new(badge_params)
      @badge.user_id = @user.id
      @badge.duration = duration

      if @badge.save
        xps = ((@user.xp.to_f + 1) / 1000).ceil * 1000 if badge_params[:name] == "level_up"
        xps = @user.xp + 500 if badge_params[:name] == "cristal"
        @user.update(xp: xps) if (badge_params[:name] == "cristal" || badge_params[:name] == "level_up")
      end

    end
  end


  def destroy

  end

private

  def badge_params
    params.require(:badge).permit(:name)
  end
end
