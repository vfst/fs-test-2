class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.date :date, null: false
      t.boolean :recurring, default: false
      t.string :schedule_type

      t.timestamps
    end
  end
end
