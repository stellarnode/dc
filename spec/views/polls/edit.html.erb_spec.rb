require 'rails_helper'

RSpec.describe "polls/edit", type: :view do
  before(:each) do
    @poll = assign(:poll, Poll.create!(
      :title => "MyString",
      :body => "MyText",
      :status => 1,
      :type => 1,
      :user => nil
    ))
  end

  it "renders the edit poll form" do
    render

    assert_select "form[action=?][method=?]", poll_path(@poll), "post" do

      assert_select "input#poll_title[name=?]", "poll[title]"

      assert_select "textarea#poll_body[name=?]", "poll[body]"

      assert_select "input#poll_status[name=?]", "poll[status]"

      assert_select "input#poll_type[name=?]", "poll[type]"

      assert_select "input#poll_user_id[name=?]", "poll[user_id]"
    end
  end
end
