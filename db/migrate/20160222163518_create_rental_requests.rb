class CreateRentalRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :rental_requests do |t|
      t.integer :user_id
      t.integer :user_book_id
      t.datetime :accepted_at
      t.datetime :returned_at
      t.timestamps
    end
  end
end
