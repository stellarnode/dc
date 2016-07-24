require 'rails_helper'

RSpec.describe "flats/show", type: :view do
  before(:each) do
    @flat = assign(:flat, Flat.create!(
      :number => 1,
      :floor => 2,
      :entrance => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
