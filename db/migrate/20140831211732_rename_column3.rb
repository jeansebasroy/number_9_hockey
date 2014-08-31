class RenameColumn3 < ActiveRecord::Migration
  def change
  	rename_column :rinks, :zip, :zip_code
  end
end
