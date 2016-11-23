class DropDoctorates < ActiveRecord::Migration
  def change
    drop_table :doctorates
  end
end
