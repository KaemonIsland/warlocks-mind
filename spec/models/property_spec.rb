require 'rails_helper'

RSpec.describe Property, type: :model do
  before(:each) do
    @property = build(:property)
  end

  it 'is valid with valid attributes' do
    expect(@property).to be_valid
  end

  it 'is invalid with a blank name' do
    @property.name = ''
    expect(@property).to_not be_valid
  end

  it 'is invalid with a name longer than 25 characters' do
    @property.name = 'a' * 26
    expect(@property).to_not be_valid
  end

  it 'must have a unique name' do
    @property.save
    @new_property = build(:property, name: @property.name)
    expect(@new_property).to_not be_valid
  end

  it 'is invalid with an empty notes' do
    @property.notes = ''
    expect(@property).to_not be_valid
  end
end
