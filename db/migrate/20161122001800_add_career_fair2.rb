class AddCareerFair2 < ActiveRecord::Migration
  def change
    add_column :events, :careerfair, :boolean
  end
end
