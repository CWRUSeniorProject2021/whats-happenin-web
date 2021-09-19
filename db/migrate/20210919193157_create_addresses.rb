class CreateAddresses < ActiveRecord::Migration[6.1]
  def up
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true, index: true, null: false
      t.string :type, :limit => 64
      t.string :full_name
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state_code
      t.string :country_code
      t.string :postal_code

      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10
      t.timestamps
    end
    add_index :addresses, :addressable_id
  end

  def down
    drop_table :addresses
  end
end
