class AddIndexToUseraddsEmail < ActiveRecord::Migration
  def change
	add_index :useradds, :email, unique: true
  end
end
