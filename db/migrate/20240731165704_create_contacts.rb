class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.references :account, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :contacts, [:account_id, :user_id], unique: true
    add_index :contacts, [:name, :user_id], unique: true
  end
end
