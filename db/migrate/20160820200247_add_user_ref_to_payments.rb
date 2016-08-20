class AddUserRefToPayments < ActiveRecord::Migration[5.0]
  def change
    add_reference :payments, :user, foreign_key: true
  end
end
