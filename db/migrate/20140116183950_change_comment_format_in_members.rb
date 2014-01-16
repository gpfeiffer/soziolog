class ChangeCommentFormatInMembers < ActiveRecord::Migration
  def up
    change_column :members, :comment, :text
  end

  def down
    change_column :members, :comment, :string
  end
end
