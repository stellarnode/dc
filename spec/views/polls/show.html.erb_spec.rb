require 'rails_helper'

RSpec.describe "polls/show", type: :view do
  
  let (:user) {
    FactoryGirl.create(:user)
  }

  before(:each) do
    @poll = assign(:poll, Poll.create!(
      :title => "MyString",
      :body => "MyText",
      :state => :created,
      :start => "2016-12-31 11:20:01",
      :finish => "2016-12-31 12:20:01",
      :poll_type => 1,
      :user => user
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyString/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(//)
  end
end
