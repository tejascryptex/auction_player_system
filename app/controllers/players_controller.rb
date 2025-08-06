class PlayersController < ApplicationController
  def create
    @team = Team.find(params[:team_id])
    @player = @team.players.build(player_params)

    if @player.save
      redirect_to team_path(@team), notice: "Player acquired successfully!"
    else
      # Required for teams/show view to work
      @players = @team.players
      @staff_members = @team.staff_members
      render "teams/show", status: :unprocessable_entity
    end
  end


  def destroy
    player = Player.find(params[:id])
    team = player.team

    # Prevent deleting the owner
    if player.name != team.owner_name
      player.destroy
      redirect_to team_path(team), alert: "Player removed successfully."
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :role, :price)
  end
end
