class AddRankToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :rank, :decimal
  end
end
