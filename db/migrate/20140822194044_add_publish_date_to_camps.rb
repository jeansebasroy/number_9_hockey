class AddPublishDateToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :publish_date, :date
  end
end
