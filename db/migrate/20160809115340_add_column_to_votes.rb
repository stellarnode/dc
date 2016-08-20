class AddColumnToVotes < ActiveRecord::Migration[5.0]
  def change
    add_reference :votes, :poll, foreign_key: true
  end
end
