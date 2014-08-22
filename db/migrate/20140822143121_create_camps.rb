class CreateCamps < ActiveRecord::Migration
  def change
    create_table :camps do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
