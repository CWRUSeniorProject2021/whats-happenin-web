class AddSchoolToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :school, null: true, foreign_key: {on_delete: :nullify}
  end
end
