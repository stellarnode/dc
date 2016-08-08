class RemovePollTypeFromPolls < ActiveRecord::Migration[5.0]
  def change
    remove_column :polls, :poll_type, :integer
    add_column :polls, :poll_type, :string
  end
end
