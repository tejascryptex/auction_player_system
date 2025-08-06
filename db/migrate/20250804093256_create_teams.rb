class CreateTeams < ActiveRecord::Migration[8.0]
  def change
    create_table :teams do |t|
      t.string :team_name
      t.string :owner_name
      t.integer :purse

      t.timestamps
    end
  end
end
