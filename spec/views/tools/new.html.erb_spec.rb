require 'rails_helper'

RSpec.describe "tools/new", type: :view do
  before(:each) do
    assign(:tool, Tool.new(
      :category => 1,
      :name => "MyString",
      :notes => "MyText",
      :cost_amount => 1,
      :cost_type => 1,
      :weight => 1,
      :source => 1
    ))
  end

  it "renders new tool form" do
    render

    assert_select "form[action=?][method=?]", tools_path, "post" do

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
