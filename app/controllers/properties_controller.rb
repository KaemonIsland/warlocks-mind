class PropertiesController < ApplicationController
  before_action :set_property, only: [:edit, :update, :destroy]
  before_action :index_view, only: [:index]
  before_action :editable, only: [:edit, :update, :destroy]

  def index
    @properties = Property.viewable_props(current_user)
  end

  def new
    @property = current_user.properties.new
  end

  def edit
  end

  def create
    @property = current_user.properties.new(property_params)

    if current_user.admin? == false && params[:property][:view_status] == 'everyone'
      flash[:warning] = "View status not allowed"
      render 'new'
    elsif @property.save
      flash[:success] = "#{@property.name} has been created"
      redirect_to user_properties_path
    else
      render 'new'
    end
  end

  def update
    if @property.update_attributes(property_params)
      flash[:success] = "#{@property.name} has been updated"
      redirect_to user_properties_path current_user
    else
      render 'edit'
    end
  end

  def destroy
    @property.destroy
    flash[:warning] = "#{@property.name} has been deleted"
    redirect_to user_properties_path current_user
  end

  private
    def set_property
      @property = Property.friendly.find(params[:id])
    end

    def property_params
      params.require(:property).permit(:name, :description, :view_status)
    end

    def editable
      return true if current_user.admin?
      redirect_to(root_path) unless current_user.id == @property.user_id
    end
end
