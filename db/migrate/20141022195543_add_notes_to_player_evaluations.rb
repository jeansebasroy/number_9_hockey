class AddNotesToPlayerEvaluations < ActiveRecord::Migration
  def change
    add_column :player_evaluations, :notes, :text
  end
end
