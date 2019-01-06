require 'rails_helper'

RSpec.describe PagesController, type: :request do
  describe 'Navigation Bar' do
    it 'has links to log in' do
      get root_path
      expect(response.body).to include("Log In")
      expect(response.body).to include("/login")
    end
    
    it 'has links to view other users when logged in' do
      user = create(:user)
      log_in_as user
      get root_path
      signed_in_links = ["Edit Profile", "/edit", "Log Out", "/logout"]
      signed_in_links.each do |link|
        expect(response.body).to include(link), "#{link.inspect} was not found."
      end
    end

    it 'has a link to view properties' do
      user = create(:user)
      log_in_as user
      get root_path
      expect(response.body).to include("Properties")
      expect(response.body).to include("users/#{user.id}/properties")
    end

    it 'has a link to view damage types' do
      user = create(:user)
      log_in_as user
      get root_path
      expect(response.body).to include("Damage Types")
      expect(response.body).to include("users/#{user.id}/damage_types")
    end

    it 'has a link to view weapons' do
      user = create(:user)
      log_in_as user
      get root_path
      expect(response.body).to include("Weapons")
      expect(response.body).to include("users/#{user.id}/weapons")
    end
  end
  
  describe "Home Page" do
    it 'has links to register a new user' do
      get root_path
      expect(response.body).to include("Sign up now!")
      expect(response.body).to include("/register")
    end
  end
end