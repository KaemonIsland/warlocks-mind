class WeaponsController < ApplicationController
  before_action :index_view, only: [:index]


  def index
    @weapons = Weapon.all
  end
end
