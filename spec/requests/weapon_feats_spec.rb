require "rails_helper"

RSpec.describe WeaponFeatsController, type: :request do
  before(:example) do
    @user = create(:user)
    log_in_as @user
    @weapon = create(:weapon, user_id: @user.id)
  end

  describe "New/Create" do

    it "renders new template and has New Weapon title" do
      get new_weapon_weapon_feat_path @weapon
      expect(response).to render_template("weapon_feats/new")
      expect(response.body).to include("New Weapon Feat | Warlock Mind")
    end

    it "renders the correct form" do
      get new_weapon_weapon_feat_path @weapon
      expect(response).to render_template("weapon_feats/_form")
      expect(response.body).to include("Add Weapon Feat")
    end

    it "renders errors if title is blank" do
      get new_weapon_weapon_feat_path @weapon
      post weapon_weapon_feats_path(@weapon), params: { weapon_feat: {
        title: '',
        description: 'This is a description'
      }}
      expect(flash.empty?).to be true
      expect(response.body).to include("The form contains 1 error.")
      expect(response).to_not redirect_to("weapons/show")
    end

    it "renders errors if description is blank" do
      get new_weapon_weapon_feat_path @weapon
      post weapon_weapon_feats_path(@weapon), params: { weapon_feat: {
        title: 'Darkvision',
        description: ''
      }}
      expect(flash.empty?).to be true
      expect(response.body).to include("The form contains 1 error.")
      expect(response).to_not redirect_to("weapons/show")
    end

    it "creates a new weapon_feat" do
      get new_weapon_weapon_feat_path @weapon
      post weapon_weapon_feats_path(@weapon), params: { weapon_feat: {
        title: 'Darkvision',
        description: 'Grants the user darkvision'
      }}
      expect(response).to redirect_to weapon_path @weapon
      follow_redirect!
      expect(response.body).to include("Darkvision")
      expect(response.body).to include("Grants the user darkvision")
    end
  end

  describe "Edit/Update" do

    it "updates a weapon_feat and shows a success flash message" do
      @weapon_feat = create(:weapon_feat, weapon_id: @weapon.id)

      expect(@weapon_feat.weapon_id).to eq(@weapon.id)

      get edit_weapon_feat_path(@weapon_feat, weapon_id: @weapon.id)

      expect(response).to render_template("weapon_feats/edit")
      expect(response.body).to include("Edit Weapon Feat")

      patch weapon_feat_path(@weapon_feat, params: { weapon_feat: {
        title: 'Darkervision',
        description: 'Grants the user darkervision'
      }, weapon_id: @weapon.id })
      expect(response).to redirect_to weapon_path @weapon
      follow_redirect!
      expect(flash.empty?).to be false
      expect(response.body).to include("Darkervision has been updated")
    end
  end

  describe "Destroy" do
    it "allows admins or weapon owner to delete weapon_feats" do
      @weapon_feat = create(:weapon_feat, weapon_id: @weapon.id)
      get weapon_path @weapon
      expect(response.body).to include("Delete")
      delete weapon_feat_path(@weapon_feat, weapon_id: @weapon.id)
      expect(response).to redirect_to weapon_path @weapon
      follow_redirect!
      expect(flash.empty?).to be false
      expect(response.body).to include("#{@weapon_feat.title} has been deleted")
    end
  end
end
