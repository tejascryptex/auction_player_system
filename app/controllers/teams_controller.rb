class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  # def create
  #   @team = Team.create(team_params)
  #   redirect_to team_path(@team)
  # end

  def create
    team_params = params[:team]

    team_name = team_params[:team_name]
    owner_name = team_params[:owner_name]

    if team_name.blank? || owner_name.blank?
      redirect_to root_path, alert: "Team name and owner name must be provided."
      return
    end

    @team = Team.find_by(team_name: team_name, owner_name: owner_name)

    if @team
      redirect_to team_path(@team), notice: "Welcome back, #{@team.team_name}!"
    else
      @team = Team.new(team_params.permit(:team_name, :owner_name, :purse, :logo, :owner_avatar))

      if @team.save
        redirect_to team_path(@team), notice: "Team created successfully!"
      else
        flash.now[:alert] = @team.errors.full_messages.to_sentence
        render :new, status: :unprocessable_entity
      end
    end
  end





  # def show
  #   @team = Team.find(params[:id])
  #    @staff_members = @team.staff_members
  # end

  def show
    @team = Team.find(params[:id])
    @players = @team.players.where(lucky_draw: false)
    @draw_players = @team.players.where(lucky_draw: true)
    @player = Player.new

    @purse_empty = @team.purse <= 0
  end




  # app/models/team.rb
  def purse_exhausted?
    purse.to_i <= 0
  end

  def download_players_pdf
    @team = Team.find(params[:id])
    @players = @team.players
    @staff = @team.staff_members # assuming association is named `managements`

    pdf = Prawn::Document.new(page_size: 'A4', page_layout: :portrait, margin: 40)
    pdf.font "Helvetica"

    # Title
    pdf.text "Godhni Premier League Season-2", size: 24, style: :bold, align: :center
    pdf.move_down 10
    pdf.text "#{@team.team_name} - Selected Players", size: 20, style: :bold, align: :center
    pdf.move_down 10
    pdf.stroke_horizontal_rule
    pdf.move_down 20

    # Summary
    pdf.text "Total Players: #{@players.count}", size: 12
    pdf.move_down 10

    # Staff Section
    if @staff.any?
      pdf.text "Staff Members:", size: 12, style: :bold
      @staff.each_with_index do |member, index|
        pdf.text "#{index + 1}. #{member.name} (#{member.role})", size: 11
      end
      pdf.move_down 20
    end

    # Player Table
    if @players.any?
      table_data = [["No.", "Player Name", "Role"]]
      @players.each_with_index do |player, index|
        table_data << [
          index + 1,
          player.name,
          player.role.titleize
          
        ]
      end

      pdf.table(table_data, header: true, width: pdf.bounds.width) do
        row(0).font_style = :bold
        row(0).background_color = "EEEEEE"
        cells.padding = 8
        cells.borders = [:bottom]
        self.row_colors = ["F9F9F9", "FFFFFF"]
      end
    else
      pdf.text "No players found for this team.", size: 12
    end

    # Footer
    pdf.number_pages "Page <page> of <total>", {
      start_count_at: 1,
      at: [pdf.bounds.right - 100, 0],
      size: 10
    }

    send_data pdf.render,
              filename: "players_list_#{@team.team_name.parameterize}.pdf",
              type: "application/pdf",
              disposition: "inline"

    
    end
    def acquire_player
      @team = Team.find(params[:id])
      # logic to add player to team
    end


  private


  def team_params
    params.require(:team).permit(:team_name, :owner_name,:purse, :logo, :owner_avatar)
  end

  
  
end
