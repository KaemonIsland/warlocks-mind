require "rails_helper"

RSpec.describe ArmorsController, type: :request do
  before(:example) do
    @user = create(:user)
    log_in_as @user
  end

  describe "index" do
    it "shows all armor" do
      get user_armors_path @user
      expect(response).to render_template 'armors/index'
      expect(response.body).to include("All Armor")
    end
  end

  describe "show" do
  end

  describe "edit" do
  end

  describe "new" do
  end

  describe "create" do
  end

  describe "update" do
  end

  describe "destroy" do
  end
end
