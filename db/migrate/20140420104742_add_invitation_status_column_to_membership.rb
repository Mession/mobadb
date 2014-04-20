class AddInvitationStatusColumnToMembership < ActiveRecord::Migration
  def change
  	    add_column :memberships, :invitation_status, :integer
  end
end
