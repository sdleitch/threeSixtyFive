class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.date :taken_on

      t.timestamps null: false
    end
  end
end
