class AddAasmStateToPolls < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :state, :string
    remove_column :polls, :status, :integer
  end
end
