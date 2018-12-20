require 'rails_helper'

RSpec.describe PagesController, type: :request do
  describe 'Registering a new user' do
    it 'opens the home page' do
      get root_path
      expect(response.body).to include('Sign up now!')
    end
  end
end