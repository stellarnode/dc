require 'rails_helper'

RSpec.describe "flats/index", type: :view do
  before(:each) do
    assign(:flats, [
      Flat.create!(
        :number => 1,
        :floor => 2,
        :entrance => 3
      ),
      Flat.create!(
        :number => 1,
        :floor => 2,
        :entrance => 3
      )
    ])
  end

  it "renders a list of flats" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
