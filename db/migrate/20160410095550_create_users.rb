class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :user_name

      t.timestamps null: false
    end
    # Adding this indexes we ensure the data will not be corrupted,
    # when dealing with validations, facing multiple web processes
    add_index :users, :email, unique: true
    add_index :users, :user_name, unique: true
  end
end
