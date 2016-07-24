require 'rails_helper'

RSpec.describe "posts/edit", :type => :view do
  
  let (:user) {
    FactoryGirl.create(:user)
  }

  before(:each) do
    @post = assign(:post, Post.create!(
      :title => "MyString",
      :body => "MyText",
      :user_id => user.id,
      :is_pinned => false,
      :is_draft => false,
      :comments_count => 1
    ))
  end

  it "renders the edit post form" do
    render

    assert_select "form[action=?][method=?]", post_path(@post), "post" do

      assert_select "input#post_title[name=?]", "post[title]"

      assert_select "textarea#post_body[name=?]", "post[body]"

      assert_select "input#post_is_pinned[name=?]", "post[is_pinned]"

      assert_select "input#post_is_draft[name=?]", "post[is_draft]"

      assert_select "input#post_comments_count[name=?]", "post[comments_count]"
    end
  end
end
