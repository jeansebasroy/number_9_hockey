class CreatePlayerEvaluations < ActiveRecord::Migration
  def change
    create_table :player_evaluations do |t|
      t.integer :player_id
      t.string :evaluation_type
      t.string :league
      t.string :team
      t.date :date

      t.timestamps
    end
  end
end
