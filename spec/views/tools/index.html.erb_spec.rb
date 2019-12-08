require 'rails_helper'

RSpec.describe "tools/index", type: :view do
  before(:each) do
    assign(:tools, [
      Tool.create!(
        :category => 2,
        :name => "Name",
        :notes => "MyText",
        :cost_amount => 3,
        :cost_type => 4,
        :weight => 5,
        :source => 6
      ),
      Tool.create!(
        :category => 2,
        :name => "Name",
        :notes => "MyText",
        :cost_amount => 3,
        :cost_type => 4,
        :weight => 5,
        :source => 6
      )
    ])
  end

  it "renders a list of tools" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
  end
end
