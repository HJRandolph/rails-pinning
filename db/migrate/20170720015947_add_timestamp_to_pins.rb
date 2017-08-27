class AddTimestampToPins < ActiveRecord::Migration
  def change
  add_column :pins, :created_at, :datetime
  add_column :pins, :updated_at, :datetime
  end
end
