class CreateDrawPlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :draw_players do |t|
      t.string :name
      t.string :role
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
