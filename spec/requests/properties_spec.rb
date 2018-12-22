require "rails_helper"

RSpec.describe PropertiesController, type: :request do
  before(:example) do
    user = create(:user)
    create(:user)
    log_in_as user
  end
  describe "Index" do
    it 'only allows the logged in user to view their own properties' do
      alt_user = create(:user)
      get user_properties_path alt_user
      expect(response).to redirect_to root_path
    end
  end
end