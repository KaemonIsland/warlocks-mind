require 'rails_helper'

RSpec.describe "tools/edit", type: :view do
  before(:each) do
    @tool = assign(:tool, Tool.create!(
      :category => 1,
      :name => "MyString",
      :notes => "MyText",
      :cost_amount => 1,
      :cost_type => 1,
      :weight => 1,
      :source => 1
    ))
  end

  it "renders the edit tool form" do
    render

    assert_select "form[action=?][method=?]", tool_path(@tool), "post" do

      assert_select "input[name=?]", "tool[category]"

      assert_select "input[name=?]", "tool[name]"

      assert_select "textarea[name=?]", "tool[notes]"

      assert_select "input[name=?]", "tool[cost_amount]"

      assert_select "input[name=?]", "tool[cost_type]"

      assert_select "input[name=?]", "tool[weight]"

      assert_select "input[name=?]", "tool[source]"
    end
  end
end
