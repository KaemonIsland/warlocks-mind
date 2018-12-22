class PropertiesController < ApplicationController
  before_action :correct_user

  def index
    @properties = current_user.properties.viewable_props
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

    def property_params
    end

    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_path) unless current_user.id == @user.id
    end
end
