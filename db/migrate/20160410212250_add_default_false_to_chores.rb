class AddDefaultFalseToChores < ActiveRecord::Migration[5.0]
  def change
    change_column :chores, :completed, :boolean, default: false
  end
end
