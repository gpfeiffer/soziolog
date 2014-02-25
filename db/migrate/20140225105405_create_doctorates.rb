class CreateDoctorates < ActiveRecord::Migration
  def change
    create_table :doctorates do |t|
      t.string :first
      t.string :last
      t.string :university
      t.string :title
      t.integer :year
      t.string :advisor
      t.string :thesis
      t.integer :genealogy_id

      t.timestamps
    end
  end
end
