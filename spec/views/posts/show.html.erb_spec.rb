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
      :comments_count => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to include("MyString")
    expect(rendered).to include("MyText")
    expect(rendered).to include("false")
    expect(rendered).to include("1")
    #expect(rendered).to match(/Title/)
    #expect(rendered).to match(/MyText/)
    #expect(rendered).to match(//)
    #expect(rendered).to match(/false/)
    #expect(rendered).to match(/false/)
    #expect(rendered).to match(/1/)
  end
end
