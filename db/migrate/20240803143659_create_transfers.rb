class CreateTransfers < ActiveRecord::Migration[7.1]
  def change
    create_table :transfers do |t|
      t.references :sender, null: false, foreign_key: { to_table: :accounts }
      t.references :recipient, null: false, foreign_key: { to_table: :accounts }
      t.integer :amount_cents, null: false
      t.string :currency, null: false
      t.string :status, null: false, default: 'pending'

      t.timestamps

      t.check_constraint 'amount_cents > 0', name: 'amount_cents_must_be_positive'
    end
  end
end
