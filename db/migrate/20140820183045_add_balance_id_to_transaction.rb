class AddBalanceIdToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :balance_id, :integer
  end
end
