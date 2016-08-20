require 'rails_helper'

RSpec.describe "payments/index", type: :view do
  before(:each) do
    assign(:payments, [
      Payment.create!(
        :receiver => "Receiver",
        :formcomment => "Formcomment",
        :short_dest => "Short Dest",
        :quickpay_form => "Quickpay Form",
        :targets => "Targets",
        :payment_type => "Payment Type",
        :sum => "Sum",
        :label => "Label",
        :comment => "Comment",
        :successURL => "Success Url",
        :need_fio => "Need Fio",
        :need_email => "Need Email",
        :need_phone => "Need Phone",
        :need_address => "Need Address"
      ),
      Payment.create!(
        :receiver => "Receiver",
        :formcomment => "Formcomment",
        :short_dest => "Short Dest",
        :quickpay_form => "Quickpay Form",
        :targets => "Targets",
        :payment_type => "Payment Type",
        :sum => "Sum",
        :label => "Label",
        :comment => "Comment",
        :successURL => "Success Url",
        :need_fio => "Need Fio",
        :need_email => "Need Email",
        :need_phone => "Need Phone",
        :need_address => "Need Address"
      )
    ])
  end

  it "renders a list of payments" do
    render
    assert_select "tr>td", :text => "Receiver".to_s, :count => 2
    assert_select "tr>td", :text => "Formcomment".to_s, :count => 2
    assert_select "tr>td", :text => "Short Dest".to_s, :count => 2
    assert_select "tr>td", :text => "Quickpay Form".to_s, :count => 2
    assert_select "tr>td", :text => "Targets".to_s, :count => 2
    assert_select "tr>td", :text => "Payment Type".to_s, :count => 2
    assert_select "tr>td", :text => "Sum".to_s, :count => 2
    assert_select "tr>td", :text => "Label".to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
    assert_select "tr>td", :text => "Success Url".to_s, :count => 2
    assert_select "tr>td", :text => "Need Fio".to_s, :count => 2
    assert_select "tr>td", :text => "Need Email".to_s, :count => 2
    assert_select "tr>td", :text => "Need Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Need Address".to_s, :count => 2
  end
end
