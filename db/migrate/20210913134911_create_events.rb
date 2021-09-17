class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title, null: false, default: "", limit: 255, index: true
      t.text :description, null: false, default: "", limit: 10000
      t.datetime :start_date, null: false, default: -> { 'CURRENT_TIMESTAMP' }, index: true
      t.datetime :end_date, null: false, default: -> { 'CURRENT_TIMESTAMP' }, index: true
      t.references :school, null: true, foreign_key: {on_delete: :restrict}, index: true
      t.references :user, null: false, foreign_key: {on_delete: :cascade}, index: true
      t.timestamps
    end
  end
end
