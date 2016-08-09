class AddVotesCountToOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :options, :votes_count, :integer
  end
end
