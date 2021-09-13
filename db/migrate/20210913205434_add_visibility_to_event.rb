class AddVisibilityToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :visibility, :integer, null: false, default: 0
  end
end
