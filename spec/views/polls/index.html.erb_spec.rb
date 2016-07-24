require 'rails_helper'

RSpec.describe "polls/index", type: :view do
  before(:each) do
    assign(:polls, [
      Poll.create!(
        :title => "Title",
        :body => "MyText",
        :status => 2,
        :type => 3,
        :user => nil
      ),
      Poll.create!(
        :title => "Title",
        :body => "MyText",
        :status => 2,
        :type => 3,
        :user => nil
      )
    ])
  end

  it "renders a list of polls" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
