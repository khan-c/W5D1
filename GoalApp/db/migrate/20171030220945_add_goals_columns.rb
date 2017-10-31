class AddGoalsColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :goals, :title, :string, null: false
    add_column :goals, :body, :text, null: false
    add_column :goals, :user_id, :integer, null: false
    add_column :goals, :private?, :boolean, null: false

    add_index :goals, :user_id
    add_index :goals, [:title, :user_id], unique: true
  end
end
