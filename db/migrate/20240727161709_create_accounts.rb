class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.string :account_type, default: 'savings', null: false
      t.integer :balance_cents, default: 0
      t.string :currency, default: 'gbp', null: false
      t.references :user, index: true, null: false, foreign_key: true

      t.timestamps
    end
  end
end
