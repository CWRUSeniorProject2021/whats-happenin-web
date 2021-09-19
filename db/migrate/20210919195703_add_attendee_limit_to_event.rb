class AddAttendeeLimitToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :attendee_limit, :integer, null: false, default: -1
  end
end
