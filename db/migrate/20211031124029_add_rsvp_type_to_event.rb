class AddRsvpTypeToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :rsvp_type, :integer, null: false, default: 0
  end
end
