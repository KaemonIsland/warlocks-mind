require 'rails_helper'

RSpec.describe Weapon, type: :model do
  before(:each) do
    @weapon = build(:weapon)
  end

  it "is valid with valid attributes" do
    expect(@weapon).to be_valid
  end

  it "is invalid with an empty name" do
    @weapon.name = ''
    expect(@weapon).to_not be_valid
  end

  it "is invalid with an name length over 25" do
    @weapon.name = 'a' * 26
    expect(@weapon).to_not be_valid
  end

  it "is valid with valid categories" do
    categories = %w(simple_melee simple_ranged martial_melee martial_ranged)
    categories.each do |cat|
      @weapon.category = cat
      expect(@weapon).to be_valid, "#{cat} is not a valid category"
    end
  end

  it "is valid with any cost amount" do
    @weapon.cost_amount = 30
    expect(@weapon).to be_valid
  end

  it "is valid with valid cost types" do
    cost_types = %w(cp sp ep gp pp)
    cost_types.each do |cost|
      @weapon.cost_type = cost
      expect(@weapon).to be_valid, "#{cost} is not a valid cost type"
    end
  end

  it "is valid with a damage amount" do
    @weapon.damage_amount = 1
    expect(@weapon).to be_valid
  end

  it "is invalid without a damage die" do
    @weapon.damage_die = nil
    expect(@weapon).to_not be_valid
  end

  it "is valid without a weight" do
    @weapon.weight = nil
    expect(@weapon).to be_valid
  end

  it "is valid with a nil range close/far" do
    @weapon.range_near = @weapon.range_far = nil
    expect(@weapon).to be_valid
  end

  it "is valid with a valid view status" do
    possible_view = %w(personal homebrew everyone)
    possible_view.each do |view|
      @weapon.view_status = view
      expect(@weapon).to be_valid, "#{view} is not a valid view status"
    end
  end

  it "is valid with nil versatile settings" do
    @weapon.versatile_amount = @weapon.versatile_die = nil
    expect(@weapon).to be_valid
  end

  it "is valid with an empty description" do
    @weapon.description = nil
    expect(@weapon).to be_valid
  end

  it "is invalid with a description over 500 words" do
    @weapon.description = 'hello' * 101
    expect(@weapon).to_not be_valid
  end

  it "adds default values to weapons if attribute nil" do
    weapon = Weapon.new(name: 'sword')
    weapon.save
    expect(weapon.category).to eq "simple_melee"
    expect(weapon.damage_amount).to eq 1
    expect(weapon.damage_die).to eq 6
    expect(weapon.modifier).to eq 0
    expect(weapon.cost_amount).to eq 0
    expect(weapon.cost_type).to eq 'cp'
    expect(weapon.weight).to eq 1
  end
end
