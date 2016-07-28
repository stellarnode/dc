class AddAasmStateToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :state, :string
    remove_column :polls, :status
  end
end
