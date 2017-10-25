class AddImageToPins < ActiveRecord::Migration
  def change
    add_attachment :pins, :image
  end
end
