class CreateTimelines < ActiveRecord::Migration[5.0]
  def change
    create_table :timelines do |t|
      t.integer :user_book_id
      t.string :timeline_type
      t.timestamps
    end
  end
end
