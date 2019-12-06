class WeaponFeatsController < ApplicationController
  before_action :set_weapon_feat, only: [:edit, :update, :destroy]
  before_action :set_weapon, only: [:new, :create]

  def new
    @weapon_feat = @weapon.weapon_feats.new
  end

  def edit
  end

  def create
    @weapon_feat = @weapon.weapon_feats.new(weapon_feat_params)

    if @weapon_feat.save
      flash[:success] = "#{@weapon_feat.title} has been created"
      redirect_to @weapon
    else
      render "new"
    end
  end

  def update
    if @weapon_feat.update_attributes(weapon_feat_params)
      flash[:success] = "#{@weapon_feat.title} has been updated"
      redirect_to @weapon
    else
      render "edit"
    end
  end

  def destroy
    @weapon_feat.delete
    flash[:warning] = "#{@weapon_feat.title} has been deleted"
    redirect_to @weapon
  end

    private

    def weapon_feat_params
      params.require(:weapon_feat).permit(:title, :notes)
    end

    def set_weapon_feat
      @weapon = Weapon.find(params[:weapon_id])
      @weapon_feat = @weapon.weapon_feats.find(params[:id])
    end

    def set_weapon
      @weapon = Weapon.find(params[:weapon_id])
    end
end
