class CreateEmails < ActiveRecord::Migration[5.0]
  def change
    create_table :emails do |t|
      t.string :subject
      t.text :body
      t.text :to
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
