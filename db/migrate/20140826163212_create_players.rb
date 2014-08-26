class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :shoots

      t.timestamps
    end
  end
end
