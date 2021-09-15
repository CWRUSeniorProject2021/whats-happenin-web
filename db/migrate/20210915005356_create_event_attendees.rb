class CreateEventAttendees < ActiveRecord::Migration[6.1]
  def change
    create_table :event_attendees do |t|
      t.integer     :rsvp_status, null: false, default: 1
      t.references  :event, null: false, foreign_key: {on_delete: :cascade}
      t.references  :user, null: false, foreign_key: {on_delete: :cascade}
      t.timestamps
    end
    add_index :event_attendees, [:event_id, :user_id], unique: true
  end
end
