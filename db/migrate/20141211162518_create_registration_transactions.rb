class CreateRegistrationTransactions < ActiveRecord::Migration
  def change
    create_table :registration_transactions do |t|
      t.integer :player_camp_registration_id
      t.string :x_amount
      t.string :x_first_name
      t.string :x_last_name
      t.string :x_trans_id
      t.string :x_type

      t.timestamps
    end
  end
end
