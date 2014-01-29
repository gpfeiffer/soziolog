class AddReceivedOnToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :received_on, :date
  end
end
