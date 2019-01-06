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

    it 'renders weapon category headers if weapon is present' do
      weapon = create(:weapon, category: "simple_melee", view_status: 'everyone')
      get user_weapons_path @user
      expect(response.body).to include("Simple Melee")
      expect(response.body).to include(weapon.name)
      expect(response.body).to_not include("Simple Ranged")
    end
  end

  describe "Show" do
    it "shows all weapon stats when clicked" do
      weapon = create(:weapon, user_id: @user.id)
      get weapon_path(weapon)
      expect(response).to render_template "weapons/show"
      expect(response.body).to include("#{weapon.name} | Warlocks Mind")
      weapon_info = ["name", "cost_type", "description"]
      weapon_info.each do |item|
        expect(response.body).to include(weapon[item]), "#{weapon[item]} was not present"
      end
    end
  end

  describe "New/Create" do
    it "renders new template and has New Weapon title" do
      get new_user_weapon_path @user
      expect(response).to render_template("weapons/new")
      expect(response).to include("New Weapon | Warlocks Mind")
    end
  end
end