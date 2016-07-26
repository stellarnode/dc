require 'rails_helper'

RSpec.describe "posts/show", :type => :view do
  
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
      :commentable => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to include("MyString")
    expect(rendered).to include("MyText")
    expect(rendered).to include("false")
    expect(rendered).to include("1")
  end
end
