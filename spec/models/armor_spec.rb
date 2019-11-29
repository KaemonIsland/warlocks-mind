require 'rails_helper'

RSpec.describe Armor, type: :model do
  before(:each) do
    @armor = build(:armor)
  end

  it "is valid" do
    expect(@armor).to be_valid
  end

  it "is invalid without a name" do
    @armor.name = ''
    expect(@armor).to_not be_valid
  end

  it "is invalid with a name more than 255 characters" do
    @armor.name = "#{'a' * 256}"
    expect(@armor).to_not be_valid
  end

  it "is invalid without a category" do
    @armor.category = ''
    expect(@armor).to_not be_valid
  end

  it "is valid with valid categories" do
    categories = %w(heavy medium light shield)
    categories.each do |cat|
      @armor.category = cat
      expect(@armor).to be_valid, "#{cat} is not a valid category"
    end
  end

  it "is valid without a armor_class" do
    @armor.armor_class = ''
    expect(@armor).to be_valid
  end

  it "is valid with an armor class ability of any of the 6 attributes" do
    abilities = %w(strength dexterity constitution intellect wisdom charisma)
    abilities.each do |abil|
      @armor.armor_class_ability = abil
      expect(@armor).to be_valid, "#{abil} is not a valid armor class ability"
    end
  end

  it "is valid with valid armor class modifiers" do
    modifiers = ["+ 2", "- 1", "4"]
    modifiers.each do |mod|
      @armor.armor_class_modifier = mod
      expect(@armor).to be_valid, "#{mod} is a valid armor class modifier"
    end
  end

  it "is valid with an empty strength_requirement" do
    @armor.strength_requirement = ''
    expect(@armor).to be_valid
  end

  it "is valid with any cost amount" do
    @armor.cost_amount = 30
    expect(@armor).to be_valid
  end

  it "is valid with valid cost types" do
    cost_types = %w(cp sp ep gp pp)
    cost_types.each do |cost|
      @armor.cost_type = cost
      expect(@armor).to be_valid, "#{cost} is not a valid cost type"
    end
  end

  it "is valid with empty notes" do
    @armor.notes = ''
    expect(@armor).to be_valid
  end

  it "is valid without a weight" do
    @armor.weight = nil
    expect(@armor).to be_valid
  end

  it "is valid with valid don/dof times" do
    times = %w(minute hour action bonus_action instant)
    times.each do |t|
      @armor.doff_time = t
      @armor.don_time = t
      expect(@armor).to be_valid, "#{t} is not a valid don/dof type"
    end
  end

end
