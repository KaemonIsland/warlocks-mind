require 'rails_helper'

RSpec.describe "pages/home" do
  it 'displays a header' do
    render
    expect(rendered).to include('Warlocks Mind')
  end
end