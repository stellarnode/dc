require 'rails_helper'

RSpec.describe "payments/new", type: :view do
  before(:each) do
    assign(:payment, Payment.new(
      :receiver => "MyString",
      :formcomment => "MyString",
      :short_dest => "MyString",
      :quickpay_form => "MyString",
      :targets => "MyString",
      :payment_type => "MyString",
      :sum => "MyString",
      :label => "MyString",
      :comment => "MyString",
      :successURL => "MyString",
      :need_fio => "MyString",
      :need_email => "MyString",
      :need_phone => "MyString",
      :need_address => "MyString"
    ))
  end

  it "renders new payment form" do
    render

    assert_select "form[action=?][method=?]", payments_path, "post" do

      assert_select "input#payment_receiver[name=?]", "payment[receiver]"

      assert_select "input#payment_formcomment[name=?]", "payment[formcomment]"

      assert_select "input#payment_short_dest[name=?]", "payment[short_dest]"

      assert_select "input#payment_quickpay_form[name=?]", "payment[quickpay_form]"

      assert_select "input#payment_targets[name=?]", "payment[targets]"

      assert_select "input#payment_payment_type[name=?]", "payment[payment_type]"

      assert_select "input#payment_sum[name=?]", "payment[sum]"

      assert_select "input#payment_label[name=?]", "payment[label]"

      assert_select "input#payment_comment[name=?]", "payment[comment]"

      assert_select "input#payment_successURL[name=?]", "payment[successURL]"

      assert_select "input#payment_need_fio[name=?]", "payment[need_fio]"

      assert_select "input#payment_need_email[name=?]", "payment[need_email]"

      assert_select "input#payment_need_phone[name=?]", "payment[need_phone]"

      assert_select "input#payment_need_address[name=?]", "payment[need_address]"
    end
  end
end
