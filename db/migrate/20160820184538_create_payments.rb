class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.string :receiver
      t.string :formcomment
      t.string :short_dest
      t.string :quickpay_form
      t.string :targets
      t.string :payment_type
      t.string :sum
      t.string :label
      t.string :comment
      t.string :successURL
      t.string :need_fio
      t.string :need_email
      t.string :need_phone
      t.string :need_address

      t.timestamps
    end
  end
end
