class DrawPlayersController < ApplicationController
  before_action :set_team

  def create
  @draw_player = @team.draw_players.new(draw_player_params)

  if @draw_player.save
    puts ">> Saved draw_player: #{@draw_player.inspect}"

    @player = @team.players.new(
      name: @draw_player.name,
      role: @draw_player.role,
      price: 0,
      lucky_draw: true
    )

    if @player.save
      puts ">> Player saved: #{@player.inspect}"
      redirect_to team_path(@team), notice: 'Lucky Draw Player added successfully.'
    else
      puts ">> Failed to save player: #{@player.errors.full_messages}"
      render :new, status: :unprocessable_entity
    end
  else
    puts ">> Failed to save draw_player: #{@draw_player.errors.full_messages}"
    render :new, status: :unprocessable_entity
  end
end


  private
  def draw_player_params
    params.require(:draw_player).permit(:name, :role)
  end

  def set_team
    @team = Team.find(params[:team_id])
  end
end
