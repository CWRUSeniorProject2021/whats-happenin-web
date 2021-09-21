class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references  :event, null: false, foreign_key: {on_delete: :cascade}
      t.references  :user, null: true, foreign_key: {on_delete: :nullify}
      t.string      :comment, null: false
      t.column      :parent_id, :bigint, null: true
      t.timestamps
    end
    add_foreign_key :comments, :comments, column: :parent_id 
  end
end
