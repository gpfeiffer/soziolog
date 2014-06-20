class AddReciprocalToMember < ActiveRecord::Migration
  def change
    add_column :members, :reciprocal, :string
  end
end
