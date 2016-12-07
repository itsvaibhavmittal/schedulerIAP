class AddEdithashToStudents < ActiveRecord::Migration
  def change
    add_column :students, :edithash, :string
  end
end
