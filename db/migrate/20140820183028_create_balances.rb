class CreateBalances < ActiveRecord::Migration
  def change
    create_table :balances do |t|
      t.integer :balance
      t.date :date
      t.integer :previous_id

      t.timestamps
    end
  end
end
