require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'Devise authentication, login, logout, and registration' do
    it "registers a new user" do
      get new_user_registration_path
      expect(response).to render_template('devise/registrations/new')
      post user_registration_path, params: { user: { name: 'Example Smith',
                                                      email: 'example@testing.com',
                                                      password: 'foobar',
                                                      password_confirmation: 'foobar' } }
      expect(response).to redirect_to('/')
      follow_redirect!
      expect(flash.empty?).to be false
      expect(response.body).to include("Welcome! You have signed up successfully.")
    end

    it 'logs in a new user with correct params' do
      user = create(:user)

      get new_user_session_path
      expect(response).to render_template('devise/sessions/new')
      post user_session_path, params: { user: { email: user.email,
                                                password: 'password' } }
      expect(response).to redirect_to('/')
      follow_redirect!
      expect(flash.empty?).to be false
      expect(response.body).to include("Signed in successfully.")
    end

    it 'will not log in a user with incorrect params' do
      user = create(:user)
      get new_user_session_path
      expect(response).to render_template('devise/sessions/new')
      post user_session_path, params: { user: { email: user.email,
                                                password: 'fakepassword' } }
      expect(flash.empty?).to be false
      expect(response.body).to include("Invalid Email or password")
    end

    it "gives the user a logout option when logged in" do
      user = create(:user)
      log_in_as user
      expect(response).to redirect_to('/')
      follow_redirect!
      expect(response.body).to include("Log Out")
    end

    it 'displays a warning alert if a logged in user attempts to log in' do
      user = create(:user)
      log_in_as user
      expect(response).to redirect_to('/')
      follow_redirect!
      get new_user_session_path
      expect(response).to redirect_to('/')
      follow_redirect!
      expect(flash.empty?).to be false
      expect(response.body).to include("You are already signed in.")
    end
  end
end