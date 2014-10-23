class AddFieldsToCamp < ActiveRecord::Migration
  def change
    add_column :camps, :price, :decimal
    add_column :camps, :highlights, :text
  end
end
