class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :year
      t.integer :member_id
      t.integer :transaction_id
      t.integer :value
      t.integer :payment
      t.date :paid_on

      t.timestamps
    end
  end
end
