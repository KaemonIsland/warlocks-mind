require "rails_helper"

RSpec.describe WeaponsController, type: :request do
  before(:example) do
    @user = create(:user)
    log_in_as @user
  end


  describe "Index" do
    it "has All Weapons in the title" do
      get user_weapons_path @user
      expect(response).to render_template 'weapons/index'
      expect(response.body).to include("All Weapons")
    end

    it 'only allows the logged in user to view their own properties' do
      alt_user = create(:user)
      get user_weapons_path alt_user
      expect(response).to redirect_to root_path
    end

    it "renders view status template" do
    get user_weapons_path @user
    expect(response).to render_template("layouts/_viewable_key")
    end

    it 'renders weapons by category' do
      get user_weapons_path @user
      create(:weapon, category: "simple_melee")
      expect(response.body).to include("Simple Melee")
    end
  end
end