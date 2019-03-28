class AddDefaultValueToTodosStatus < ActiveRecord::Migration[5.2]
  def up
    change_column :todos, :status, :integer, null: true, default: 0
  end

  # def down
  #   change_column :todos, :status, :integer, null: false, default: 0
  # end
end
