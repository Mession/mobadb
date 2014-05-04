class AddCommentToRoleRating < ActiveRecord::Migration
  def change
  	add_column :role_ratings, :comment, :text
  end
end
