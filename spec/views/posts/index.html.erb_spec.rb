require 'rails_helper'

RSpec.describe "posts/index", :type => :view do
  
  let (:user) {
    FactoryGirl.create(:user)
  }

  before(:each) do
    assign(:posts, [
      Post.create!(
        :title => "MyString",
        :body => "MyText",
        :user_id => user.id,
        :is_pinned => false,
        :is_draft => false,
        :commentable => false
      ),
      Post.create!(
        :title => "MyString",
        :body => "MyText",
        :user_id => user.id,
        :is_pinned => false,
        :is_draft => false,
        :commentable => false
      )
    ])
  end

  it "renders a list of posts" do
    render
    assert_select "tr>td", :text => "MyString", :count => 2
    assert_select "tr>td", :text => "MyText", :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 6
  end
end
