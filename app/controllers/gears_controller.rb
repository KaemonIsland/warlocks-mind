class GearsController < ApplicationController
  before_action :set_gear, only: [:show, :edit, :update, :destroy]

  def index
    @gears = Gear.all
  end

  def show
  end

  def new
    @gear = current_user.gears.new
  end

  def edit
  end

  def create
    @gear = current_user.gears.new(gear_params)

    if @gear.save
      flash[:success] = "#{@gear.name} has been created"
      redirect_to @gear
    else
      render "new"
    end
  end

  def update
    if @gear.update_attributes(gear_params)
      flash[:success] = "#{@gear.name} has been updated"
      redirect_to @gear
    else
      render "edit"
    end
  end

  def destroy
    if @gear.destroy
      flash[:danger] = "#{@gear.name} has been deleted"
      redirect_to user_gears_path current_user
    else
      redirect_to @gear
    end
  end

  private
    def set_gear
      @gear = Gear.find(params[:id])
    end

    def gear_params
      params.require(:gear).permit(:name, :notes, :cost_amount, :cost_type, :weight, :category)
    end
end
