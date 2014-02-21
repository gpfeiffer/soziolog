class AddEmailToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :email, :string
  end
end
