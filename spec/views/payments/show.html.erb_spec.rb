require 'rails_helper'

RSpec.describe "payments/show", type: :view do
  before(:each) do
    @payment = assign(:payment, Payment.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Receiver/)
    expect(rendered).to match(/Formcomment/)
    expect(rendered).to match(/Short Dest/)
    expect(rendered).to match(/Quickpay Form/)
    expect(rendered).to match(/Targets/)
    expect(rendered).to match(/Payment Type/)
    expect(rendered).to match(/Sum/)
    expect(rendered).to match(/Label/)
    expect(rendered).to match(/Comment/)
    expect(rendered).to match(/Success Url/)
    expect(rendered).to match(/Need Fio/)
    expect(rendered).to match(/Need Email/)
    expect(rendered).to match(/Need Phone/)
    expect(rendered).to match(/Need Address/)
  end
end
