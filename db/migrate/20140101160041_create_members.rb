class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :number
      t.string :title
      t.string :surname
      t.string :forename
      t.text :address
      t.string :email
      t.string :status
      t.string :comment

      t.timestamps
    end
  end
end
