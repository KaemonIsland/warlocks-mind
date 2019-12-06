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

    it "has a new weapon link" do
      get user_weapons_path @user
      expect(response.body).to include("Create a new weapon")
      expect(response.body).to include("/users/#{@user.id}/weapons/new")
    end
  end

  describe "Show" do
    it "shows all weapon stats when clicked" do
      weapon = create(:weapon, user_id: @user.id)
      get weapon_path(weapon)
      expect(response).to render_template "weapons/show"
      expect(response.body).to include("#{weapon.name} | Warlock Mind")
      weapon_info = ["name", "cost_type", "notes"]
      weapon_info.each do |item|
        expect(response.body).to include(weapon[item]), "#{weapon[item]} was not present"
      end
    end

    it "redirects user trying to view another users personal weapon" do
      weapon = create(:weapon, user_id: @user.id)
      log_out @user
      alt_user = create(:user)
      log_in_as(alt_user)
      get weapon_path weapon
      expect(response).to redirect_to root_path
    end

    it "includes edit path if weapon belongs to user" do
      weapon = create(:weapon, user_id: @user.id)
      alt_user = create(:user)
      alt_weapon = create(:weapon, user_id: alt_user.id)

      get weapon_path weapon
      expect(response.body).to include("Edit")
      get weapon_path alt_weapon
      expect(response.body).to_not include("Edit")
    end
  end

  describe "New/Create" do
    it "renders new template and has New Weapon title" do
      get new_user_weapon_path @user
      expect(response).to render_template("weapons/new")
      expect(response.body).to include("New Weapon | Warlock Mind")
    end

    it "renders the correct form" do
      get new_user_weapon_path @user
      expect(response).to render_template("weapons/_form")
      expect(response.body).to include("Create New Weapon")
    end

    it "renders errors if name is blank" do
      get new_user_weapon_path @user
      post user_weapons_path(@user), params: { weapon: {
        name: ''
      }}
      expect(flash.empty?).to be true
      expect(response.body).to include("The form contains 1 error.")
      expect(response).to_not redirect_to("weapons/show")
    end

    it "creates a Simple Melee weapon" do
      get new_user_weapon_path @user
      post user_weapons_path(@user), params: { weapon: { 
        name: "Club",
        category: "simple_melee",
        cost_amount: 1,
        cost_type: 'sp',
        damage_amount: 1,
        damage_die: 4,
        weight: 2,
        notes: "This is a club"
      } }
      weapon = assigns(:weapon)
        expect(response).to redirect_to weapon_path weapon
        follow_redirect!
        expect(response.body).to include("Club")
        expect(response.body).to include("This is a club")
    end

    it "creates a Simple Ranged weapon" do
      get new_user_weapon_path @user
      post user_weapons_path(@user), params: { weapon: { 
        name: "Dart",
        category: "simple_ranged",
        cost_amount: 5,
        cost_type: 'cp',
        damage_amount: 1,
        damage_die: 4,
        weight: 0,
        range_near: 20,
        range_far: 60,
        notes: "This is a dart",
      } }
      weapon = assigns(:weapon)
        expect(response).to redirect_to weapon_path weapon
        follow_redirect!
        expect(response.body).to include("Dart")
        expect(response.body).to include("(20 / 60)")
    end

    it "creates a Martial Melee weapon" do
      get new_user_weapon_path @user
      post user_weapons_path(@user), params: { weapon: { 
        name: "Battleaxe",
        category: "martial_melee",
        cost_amount: 10,
        cost_type: 'gp',
        damage_amount: 1,
        damage_die: 8,
        weight: 4,
        versatile_amount: 1,
        versatile_die: 10,
        notes: "This is a battleaxe"
      } }
      weapon = assigns(:weapon)
        expect(response).to redirect_to weapon_path weapon
        follow_redirect!
        expect(response.body).to include("Battleaxe")
        expect(response.body).to include("This is a battleaxe")
    end

    it "creates a Martial Ranged weapon" do
      get new_user_weapon_path @user
      post user_weapons_path(@user), params: { weapon: { 
        name: "Blowgun",
        category: "martial_ranged",
        cost_amount: 10,
        cost_type: 'gp',
        damage_amount: 1,
        damage_die: 1,
        weight: 1,
        range_near: 25,
        range_far: 100,
        notes: "This is a blowgun"
      } }
      weapon = assigns(:weapon)
        expect(response).to redirect_to weapon_path weapon
        follow_redirect!
        expect(response.body).to include("Blowgun")
        expect(response.body).to include("(25 / 100)")
    end
  end

  describe "Edit/Update" do

    it "updates a weapon and shows a success flash message" do
      log_in_as(@user)
      weapon = create(:weapon, user_id: @user.id)
      expect(weapon.user_id).to eq(@user.id)
      get edit_weapon_path weapon
      expect(response).to render_template("weapons/edit")
      expect(response.body).to include("Edit Weapon")
      patch weapon_path(weapon), params: { weapon: {
        name: "Updated Name",
        modifier: 3,
        category: 'simple_ranged',
        cost_amount: 33,
        cost_type: 'gp',
        damage_amount: 3,
        damage_die: 12,
        weight: 33,
        weapon_damage_types_attributes: { "0" => { damage_type_id: '' } },
        range_near: 30,
        range_far: 300,
        notes: "This is an updated notes"
      } }
      new_weapon = assigns(:weapon)
      expect(response).to redirect_to weapon_path new_weapon
      follow_redirect!
      expect(flash.empty?).to be false
      expect(response.body).to include("Updated name")
    end

    it "does not allow a non admin user to edit weapons that are not their own" do
      @user.admin = true
      weapon = create(:weapon, user_id: @user.id)
      log_out(@user)
      alt_user = create(:user)
      log_in_as(alt_user)
      get edit_weapon_path weapon
      expect(response).to redirect_to root_path
    end
  end

  describe "Destroy" do
    it "allows admins or weapon owner to delete weapons" do
      weapon = create(:weapon, user_id: @user.id)
      get weapon_path weapon
      expect(response.body).to include("Delete")
      delete weapon_path weapon
      expect(response).to redirect_to user_weapons_path @user
      follow_redirect!
      expect(flash.empty?).to be false
      expect(response.body).to include("#{weapon.name} has been deleted")
    end

    it "does not allow users to delete other users weapons" do
      weapon = create(:weapon, user_id: @user.id)
      log_out @user
      alt_user = create(:user)
      log_in_as alt_user
      get weapon_path weapon
      expect(response.body).to_not match /Delete/
      delete weapon_path weapon
      expect(response).to_not redirect_to user_weapons_path alt_user
    end
  end
end
