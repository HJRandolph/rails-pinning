require 'spec_helper'

RSpec.describe "boards/index", type: :view do
  before(:each) do
		@user = FactoryGirl.create(:user)
		login(@user)

    assign(:boards, [
      Board.create!(
        :name => "Name",
        :user => nil
      ),
      Board.create!(
        :name => "Name",
        :user => nil
      )
    ])
  end

  it "renders a list of boards" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
