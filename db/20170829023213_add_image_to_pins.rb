class AddImageToPins < ActiveRecord::Migration
  def change
    add_column :pins, :image_file_name, :string
    add_column :pins, :image_content_type, :string
    add_column :pins, :image_file_size, :string
  end
end
