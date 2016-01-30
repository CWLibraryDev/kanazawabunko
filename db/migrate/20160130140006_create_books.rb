class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :url
      t.text :image_url
      t.text :description

      t.timestamps
    end
  end
end
