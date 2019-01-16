class WeaponsController < ApplicationController
  before_action :set_weapon, only: [:show, :edit, :update, :destroy, :remove_attribute]
  before_action :index_view, only: [:index]
  before_action :viewable, only: [:show]
  before_action :editable, only: [:edit, :udpate, :destroy]

  def index
    @weapons = Weapon.all
  end

  def show
  end

  def edit
    unless @weapon.damage_types.count >= 1
      1.times { @weapon.weapon_damage_types.build }
    end

    unless @weapon.properties.count >= 1
      1.times { @weapon.weapon_properties.build }
    end
  end

  def new
    @weapon = current_user.weapons.new
    1.times { @weapon.weapon_damage_types.build }
    1.times { @weapon.weapon_properties.build }
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

  def remove_attribute
    flash[:warning] = "Attribute has been removed"
    @weapon.remove(params[:attr], params[:index])
    redirect_to @weapon
  end

  private
    def dublicate_id?(id)
      @weapon = Weapon.find(params[:id])
      @weapon.damage_types.each do |damage_type|
        if damage_type.id == id
          return true
        end
      end
      return false
    end

    def set_weapon
      @weapon = Weapon.find(params[:id])
    end

    def weapon_params
      params.require(:weapon).permit(:name, 
                                     :category, 
                                     :cost_amount, 
                                     :cost_type, 
                                     :damage_amount, 
                                     :damage_die, 
                                     :weight, 
                                     :range_near, 
                                     :range_far, 
                                     :view_status, 
                                     :versatile_amount, 
                                     :versatile_die, 
                                     :description, 
                                     weapon_damage_types_attributes: [:damage_type_id],
                                     weapon_properties_attributes: [:property_id]
                                     )
    end

    def viewable
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
     redirect_to root_path unless current_user.id == @weapon.user_id
    end
end
