require 'rails_helper'

RSpec.describe Gear, type: :model do
  before(:each) do
    @gear = build(:gear)
  end

  it "is valid with valid attributes" do
    expect(@gear).to be_valid
  end

  it "capitalizes the name after save" do
    expect(@gear.name).to eq('abacus')
    @gear.save
    expect(@gear.name).to eq('Abacus')
  end

  it "is invalid if the name is too long" do
    @gear.name = "a" * 256
    expect(@gear).to_not be_valid
  end

  it "is invalid if the name is nil" do
    @gear.name = nil
    expect(@gear).to_not be_valid
    @gear.name = ''
    expect(@gear).to_not be_valid
  end

  it "is valid with valid cost types" do
    categories = %w(general ammunition arcane_focus druidic_focus holy_symbol)
    categories.each do |cat|
      @gear.category = cat
      expect(@gear).to be_valid, "#{cat} is not a valid gear category"
    end
  end

  it "is valid with valid cost types" do
    cost_types = %w(cp sp ep gp pp)
    cost_types.each do |cost|
      @gear.cost_type = cost
      expect(@gear).to be_valid, "#{cost} is not a valid cost type"
    end
  end
end
