class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    # Adding this index will improve the DB when retreiving all the messages
    # from a user
    add_index :messages, [:user_id, :created_at]
  end
end
