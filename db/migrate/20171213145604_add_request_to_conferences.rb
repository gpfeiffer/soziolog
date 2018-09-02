class AddRequestToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :request, :integer
  end
end
