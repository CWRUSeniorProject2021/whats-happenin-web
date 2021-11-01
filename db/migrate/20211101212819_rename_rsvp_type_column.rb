class RenameRsvpTypeColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :events, :rsvp_type, :restricted
  end
end
