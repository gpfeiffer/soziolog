class CreateFundings < ActiveRecord::Migration
  def change
    create_table :fundings do |t|
      t.integer :conference_id
      t.integer :transaction_id

      t.timestamps
    end
  end
end
