class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.date :date
      t.string :text
      t.integer :amount
      t.text :comment

      t.timestamps
    end
  end
end
