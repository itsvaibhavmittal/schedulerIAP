class AddPasswordDigestToUseradds < ActiveRecord::Migration
  def change
    add_column :useradds, :password_digest, :string
  end
end
