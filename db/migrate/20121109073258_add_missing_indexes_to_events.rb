class AddMissingIndexesToEvents < ActiveRecord::Migration
  def change
    add_index :events, :user_id
    add_index :events, :recurring
    add_index :events, :schedule_type
  end
end
