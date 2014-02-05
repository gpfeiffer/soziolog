class AddBulletinToMember < ActiveRecord::Migration
  def change
    add_column :members, :bulletin, :string
  end
end
