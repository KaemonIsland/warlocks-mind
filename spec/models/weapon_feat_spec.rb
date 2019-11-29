require 'rails_helper'

RSpec.describe WeaponFeat, type: :model do
  before(:each) do
    @user = create(:user)
    @weapon = create(:weapon)
  end

  it "adds a weapon_feat to the weapon" do
    weapon_feat = @weapon.weapon_feats.create!({ title: 'Darkvision', description: 'This is a description' })

    expect(weapon_feat.weapon_id).to eq(@weapon.id)
  end

  it "It must have a title" do
    weapon_feat = @weapon.weapon_feats.new({ description: 'This is Darkvision' })

    expect(weapon_feat).to_not be_valid
  end

  it "Must have a title shorter than 255 Characters" do
    weapon_feat = @weapon.weapon_feats.new({ title: "#{'a' * 256}", description: 'This is a long title'})

    expect(weapon_feat).to_not be_valid
  end

  it "It must have a Descpription" do
    weapon_feat = @weapon.weapon_feats.new({ title: 'Darkvision' })

    expect(weapon_feat).to_not be_valid
  end
end
