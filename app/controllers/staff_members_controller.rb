class StaffMembersController < ApplicationController
  def create
    @team = Team.find(params[:team_id])
    @staff = @team.staff_members.create(staff_member_params)
    redirect_to team_path(@team), notice: "Staff member removed successfully."
  end

  def destroy
    @team = Team.find(params[:team_id])
    @staff = @team.staff_members.find(params[:id])
    @staff.destroy
    redirect_to team_path(@team), alert: "Staff member removed successfully."
  end
  

  private

  def staff_member_params
    params.require(:staff_member).permit(:name, :role, :photo)
  end
end
