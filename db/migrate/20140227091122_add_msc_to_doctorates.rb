class AddMscToDoctorates < ActiveRecord::Migration
  def change
    add_column :doctorates, :msc, :string
  end
end
