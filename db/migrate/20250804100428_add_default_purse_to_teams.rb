class AddDefaultPurseToTeams < ActiveRecord::Migration[7.1]
  def change
    change_column_default :teams, :purse, 3000000
  end
end
