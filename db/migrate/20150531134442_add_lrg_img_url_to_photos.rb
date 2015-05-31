class AddLrgImgUrlToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :lrg_image_url, :string
  end
end
