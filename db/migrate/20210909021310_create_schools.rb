class CreateSchools < ActiveRecord::Migration[6.1]
  def change
    create_table :schools do |t|
      t.string :name, null: false, default: "", index: true
      t.timestamps
    end
  end
end
