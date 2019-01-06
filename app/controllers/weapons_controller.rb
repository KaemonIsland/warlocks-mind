class WeaponsController < ApplicationController
  before_action :index_view, only: [:index]

  def index
    @weapons = Weapon.all
  end

  def show
    @weapon = Weapon.find(params[:id])
  end
end
