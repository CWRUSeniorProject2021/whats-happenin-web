class CreateDomains < ActiveRecord::Migration[6.1]
  def change
    create_table :domains do |t|
      t.string :domain, null: false, default: ""
      t.references :school, null: false, foreign_key: {on_delete: :cascade}, index: true
      t.index :domain, unique: true
    end
  end
end
