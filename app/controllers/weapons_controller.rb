class WeaponsController < ApplicationController
  before_action :index_view, only: [:index]
  before_action :set_weapon, only: [:show, :edit, :update, :destroy]
  before_action :can_view, only: [:show]
  before_action :editable, only: [:edit, :udpate, :destroy]

  def index
    @weapons = Weapon.all
  end

  def show
  end

  def edit
  end

  def new
    @weapon = current_user.weapons.new
  end

  def create
    @weapon = current_user.weapons.new(weapon_params)

    if current_user.admin? == false && params[:weapon][:view_status] == 'everyone'
      flash[:warning] = "View status not allowed"
      render 'new'
    elsif @weapon.save
      flash[:success] = "#{@weapon.name} has been created"
      redirect_to @weapon
    else
      render "new"
    end
  end

  def update
    if @weapon.update_attributes(weapon_params)
      flash[:success] = "#{@weapon.name} has been updated"
      redirect_to @weapon
    else
      render "edit"
    end
  end

  def destroy
    @weapon.delete
    flash[:warning] = "#{@weapon.name} has been deleted"
    redirect_to user_weapons_path current_user
  end

  private
    def set_weapon
      @weapon = Weapon.find(params[:id])
    end

    def weapon_params
      params.require(:weapon).permit(:name, :category, :cost_amount, :cost_type, :damage_amount, :damage_die, :weight, :range_near, :range_far, :view_status, :versatile_amount, :versatile_die, :description)
    end

    def can_view
      return true if current_user.admin?

      @weapon = Weapon.find(params[:id])
      if @weapon.view_status == "everyone"
        return true
      else
        redirect_to(root_path) unless current_user.id == @weapon.user_id
      end
    end

    def editable
      return true if current_user.admin?

      @weapon = Weapon.find(params[:id])
     redirect_to root_path unless current_user.id == @weapon.user_id
    end
end
