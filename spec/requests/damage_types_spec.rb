require "rails_helper"

RSpec.describe DamageTypesController, type: :request do
  before(:example) do
    @user = create(:user)
    create(:user)
    log_in_as @user
  end

  describe "Index" do
    it 'only allows the logged in user to view their own damage_types' do
      alt_user = create(:user)
      get user_damage_types_path alt_user
      expect(response).to redirect_to root_path
    end

    it "has damage_types in the title" do
      get user_damage_types_path @user
      expect(response.body).to include("Damage Types | Warlock Mind")
    end

    it "has a key for Personal and Everyone view status" do
      get user_damage_types_path @user
      expect(response.body).to include("view__everyone")
      expect(response.body).to include("view__personal")
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

    it "renders a form for name, description and view status" do
      get new_user_damage_type_path @user
      form_elements = ["name", "description", "view_status"]

      form_elements.each do |elem|
        expect(response.body).to include(elem), "#{elem.inspect} was not found."
      end
    end

    it "accepts proper attributes on submit" do
      get new_user_damage_type_path @user
      post user_damage_types_path(@user), params: { damage_type: {
        name: "Acid",
        description: "This weapon deals Acid damage"
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
        description: ''
      } }
      expect(response.body).to include("Name can&#39;t be blank")
      expect(response.body).to include("Description can&#39;t be blank")
    end

    it "allows admin to select everyone view status" do
      log_out @user
      admin = create(:user, admin: true)
      log_in_as admin
      get new_user_damage_type_path admin
      post user_damage_types_path(admin), params: { damage_type: {
        name: "Acid",
        description: "This is a Acid weapon",
        view_status: 'everyone'
      } }
      expect(response).to redirect_to user_damage_types_path
      follow_redirect!
      expect(response.body).to include("Acid")
      expect(response.body).to include("item__view--everyone")
    end

    it "doesn't allow non-admins to select everyone status" do
      @user.admin = false
      expect(@user.admin).to be false
      get new_user_damage_type_path @user
      expect(response.body).to_not include("Everyone")
      post user_damage_types_path(@user), params: { damage_type: {
        name: "Acid",
        description: "This is a Acid weapon",
        view_status: 'everyone'
      }}
      expect(flash.empty?).to be false
      expect(response.body).to_not redirect_to user_damage_types_path
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
        description: "This is also Updated"
      }}
      expect(response).to redirect_to user_damage_types_path @user
      follow_redirect!
      expect(response.body).to include("Updated acid")
    end

    it "does not allow non admins to edit damage_types with everyone view status" do
      prop = create(:damage_type, user_id: 132)
      expect(@user.admin?).to be false
      get user_damage_types_path @user
      expect(response.body).to_not include("Update")
      get edit_damage_type_path prop
      expect(response).to_not render_template("damage_types/edit")
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
