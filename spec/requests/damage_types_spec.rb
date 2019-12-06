require "rails_helper"

RSpec.describe DamageTypesController, type: :request do
  before(:example) do
    @user = create(:user)
    create(:user)
    log_in_as @user
  end

  describe "Index" do
    it "has damage_types in the title" do
      get user_damage_types_path @user
      expect(response.body).to include("Damage Types | Warlock Mind")
    end
  end

  describe "New/Create" do
    it "has a link on the index page" do
      get user_damage_types_path @user
      expect(response.body).to include("Create a new damage type")
      expect(response.body).to include("/users/#{@user.id}/damage_types/new")
    end

    it "redirects to the new template" do
      get new_user_damage_type_path @user
      expect(response).to render_template "damage_types/new"
    end

    it "renders a form for name, notes" do
      get new_user_damage_type_path @user
      form_elements = ["name", "notes"]

      form_elements.each do |elem|
        expect(response.body).to include(elem), "#{elem.inspect} was not found."
      end
    end

    it "accepts proper attributes on submit" do
      get new_user_damage_type_path @user
      post user_damage_types_path(@user), params: { damage_type: {
        name: "Acid",
        notes: "This weapon deals Acid damage"
      } }
      expect(flash.empty?).to be false
      expect(response).to redirect_to user_damage_types_path
      follow_redirect!
      expect(response.body).to include("Acid damage has been created")
      expect(response.body).to include("Acid")
    end

    it "lists errors in the form if any" do
      get new_user_damage_type_path @user
      post user_damage_types_path(@user), params: { damage_type: {
        name: '',
        notes: ''
      } }
      expect(response.body).to include("Name can&#39;t be blank")
      expect(response.body).to include("Notes can&#39;t be blank")
    end
  end

  describe "Edit/Update" do
    it 'allows user to edit if admin or owner' do
      prop = create(:damage_type, user_id: @user.id)
      get user_damage_types_path @user
      expect(response.body).to include("Update")
      get edit_damage_type_path prop
      expect(response).to render_template("damage_types/edit")
      patch damage_type_path(prop), params: { damage_type: {
        name: "Updated Acid",
        notes: "This is also Updated"
      }}
      expect(response).to redirect_to user_damage_types_path @user
      follow_redirect!
      expect(response.body).to include("Updated acid")
    end

    it "changes title to Edit damage_type" do
      prop = create(:damage_type, user_id: @user.id)
      get edit_damage_type_path prop
      expect(response.body).to include("Edit Damage Type | Warlock Mind")
    end
  end

  describe "Destroy" do
    it "only damage_types that belong to the user and admins can delele damage_types" do
      prop = create(:damage_type, user_id: @user.id)
      get user_damage_types_path @user
      expect(response.body).to include("Delete")
      delete damage_type_path prop
      expect(response).to redirect_to user_damage_types_path @user
      expect(response.body).to_not include(prop.name)
    end
  end
end
