class AddLengthToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :length, :integer
  end
end
