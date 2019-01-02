class DamageTypesController < ApplicationController
  before_action :set_damage_type, only: [:edit, :update, :destroy]
  before_action :index_view, only: [:index]
  before_action :can_edit, only: [:edit, :update, :destroy]

  def index
    @damage_types = DamageType.viewable_damage_types(current_user)
  end

  def new
    @damage_type = current_user.damage_types.new
  end

  def edit
  end

  def create
    @damage_type = current_user.damage_types.new(damage_type_params)

    if current_user.admin? == false && params[:damage_type][:view_status] == 'everyone'
      flash[:warning] = "View status not allowed"
      render 'new'
    elsif @damage_type.save
      flash[:success] = "#{@damage_type.name} has been created"
      redirect_to user_damage_types_path
    else
      render 'new'
    end
  end

  def update
    if @damage_type.update_attributes(damage_type_params)
      flash[:success] = "#{@damage_type.name} has been updated"
      redirect_to user_damage_types_path current_user
    else
      render 'edit'
    end
  end

  def destroy
    @damage_type.destroy
    flash[:warning] = "#{@damage_type.name} has been deleted"
    redirect_to user_damage_types_path current_user
  end

  private

    def damage_type_params
      params.require(:damage_type).permit(:name, :description, :view_status)
    end

    def set_damage_type
      @damage_type = DamageType.friendly.find(params[:id])
    end

    def can_edit
      return true if current_user.admin?

      @damage_type = DamageType.friendly.find(params[:id])
      redirect_to(root_path) unless current_user.id == @damage_type.user_id
    end

    def index_view
      @user = User.find(params[:user_id])
      redirect_to(root_path) unless current_user.id == @user.id
    end
end
