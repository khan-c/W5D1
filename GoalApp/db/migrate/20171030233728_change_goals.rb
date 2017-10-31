class ChangeGoals < ActiveRecord::Migration[5.1]
  def change
    rename_column :goals, :private?, :private
  end
end
