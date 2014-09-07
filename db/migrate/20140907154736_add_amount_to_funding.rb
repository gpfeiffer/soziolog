class AddAmountToFunding < ActiveRecord::Migration
  def change
    add_column :fundings, :amount, :integer
  end
end
