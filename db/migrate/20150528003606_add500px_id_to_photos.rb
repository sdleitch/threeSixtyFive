class Add500pxIdToPhotos < ActiveRecord::Migration
  def change
  	add_column :photos, :px_id, :integer
  end
end
