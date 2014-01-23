class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.string :call
      t.string :name
      t.string :host
      t.date :date
      t.string :applicant
      t.text :description
      t.integer :funding

      t.timestamps
    end
  end
end
