class Pin < ActiveRecord::Base
  belongs_to :category
  
  validates_presence_of :title, :url, :slug, :text, :category_id
  validates_uniqueness_of :slug




################################### The Last End ###################################  
end