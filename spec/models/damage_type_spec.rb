require 'rails_helper'

RSpec.describe DamageType, type: :model do
  before(:each) do
    @damage_type = build(:damage_type)
  end

  it 'is valid with valid attributes' do
    expect(@damage_type).to be_valid
  end

  it 'is invalid with a blank name' do
    @damage_type.name = ''
    expect(@damage_type).to_not be_valid
  end

  it 'is invalid with a name longer than 25 characters' do
    @damage_type.name = 'a' * 26
    expect(@damage_type).to_not be_valid
  end

  it 'must have a unique name' do
    @damage_type.save
    @new_damage_type = build(:damage_type, name: @damage_type.name)
    expect(@new_damage_type).to_not be_valid
  end

  it 'is invalid with an empty notes' do
    @damage_type.notes = ''
    expect(@damage_type).to_not be_valid
  end
end
