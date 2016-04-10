class CreateChores < ActiveRecord::Migration[5.0]
  def change
    create_table :chores do |t|
      t.string :name
      t.references :category, foreign_key: true
      t.text :description
      t.boolean :completed

      t.timestamps
    end
  end
end
