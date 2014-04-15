class AddTeamLeaderToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :team_leader, :boolean
  end
end
