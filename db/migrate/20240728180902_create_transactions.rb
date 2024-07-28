class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references  :sender, null: false, foreign_key: { to_table: :accounts }
      t.references  :recipient, null: false, foreign_key: { to_table: :accounts }
      t.integer :amount_cents, null: false
      t.string  :status, null: false, default: 'pending'

      t.timestamps
    end
  end
end
