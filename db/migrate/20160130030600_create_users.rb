class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.text :google_uid
      t.text :icon_url
      t.string :email

      t.timestamps
    end
  end
end
