require 'rails_helper'

RSpec.describe "polls/index", type: :view do
  
  let (:user) {
    FactoryGirl.create(:user)
  }

  before(:each) do
    assign(:polls, [
      Poll.create!(
      :title => "MyString",
      :body => "MyText",
      :state => :created,
      :start => "2016-12-31 11:20:01",
      :finish => "2016-12-31 12:20:01",
      :poll_type => 1,
      :user => user
      ),
      Poll.create!(
      :title => "MyString",
      :body => "MyText",
      :state => :created,
      :start => "2016-12-31 11:20:01",
      :finish => "2016-12-31 12:20:01",
      :poll_type => 1,
      :user => user
      )
    ])
  end

  it "renders a list of polls" do
    render
    assert_select "tr>td", :text => "MyString".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
