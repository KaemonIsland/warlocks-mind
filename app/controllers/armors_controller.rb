class ArmorsController < ApplicationController
  before_action :set_armor, only: [:show, :edit, :update, :destroy]

  def index
    @armors = Armor.order("created_at DESC")
  end

  def show
  end

  def edit
  end

  def new
    @armor = current_user.armors.new
  end

  def create
    @armor = current_user.armors.new(armor_params)

    if @armor.save
      flash[:success] = "#{@armor.name} has been created"
      redirect_to @armor
    else
      render "new"
    end
  end

  def update
    if @armor.update_attributes(armor_params)
      flash[:success] = "#{@armor.name} has been updated"
      redirect_to @armor
    else
      render "edit"
    end
  end

  def destroy
    if @armor.destroy
      flash[:danger] = "#{@armor.name} has been deleted"
      redirect_to user_armors_path current_user
    else
      redirect_to @armor
    end
  end

  private

    def armor_params
      params.require(:armor).permit(
        :name,
        :category,
        :armor_class,
        :armor_class_ability,
        :armor_class_max,
        :armor_class_modifier,
        :strength_requirement,
        :stealth_disadvantage,
        :cost_amount,
        :cost_type,
        :notes,
        :weight,
        :don,
        :don_time,
        :doff,
        :doff_time
      )
    end

    def set_armor
      @armor = Armor.find(params[:id])
    end
end
