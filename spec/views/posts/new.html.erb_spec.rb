require 'rails_helper'

RSpec.describe "posts/new", :type => :view do

  let (:user) {
    FactoryGirl.create(:user)
  }

  before(:each) do
    assign(:post, Post.new(
      :title => "MyString",
      :body => "MyText",
      :user_id => user.id,
      :is_pinned => false,
      :is_draft => false,
      :commentable => false
    ))
  end

  it "renders new post form" do
    render

    assert_select "form[action=?][method=?]", posts_path, "post" do

      assert_select "input#post_title[name=?]", "post[title]"

      assert_select "textarea#post_body[name=?]", "post[body]"

      assert_select "input#post_is_pinned[name=?]", "post[is_pinned]"

      assert_select "input#post_is_draft[name=?]", "post[is_draft]"

      assert_select "input#post_commentable[name=?]", "post[commentable]"
    end
  end
end
