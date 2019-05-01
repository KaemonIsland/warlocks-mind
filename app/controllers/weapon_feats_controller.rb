class WeaponFeatsController < ApplicationController

  def new
    @weapon = current_user.weapons.find(params[:weapon_id])
    @weapon_feat = @weapon.weapon_feats.new
  end

  def edit

  end

  def create

  end

  def update

  end

  def destroy
    
  end
end
