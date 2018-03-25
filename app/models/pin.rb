class Pin < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  
  has_many :pinnings
  has_many :users, through: :pinnings
  has_many :boards, through: :pinnings
  
  accepts_nested_attributes_for :pinnings
  
  validates_presence_of :title, :url, :slug, :text, :category_id
  validates_uniqueness_of :slug

  has_attached_file :image, styles: { medium: "300x300", thumb: "60x60" },
  default_url: "http://placebear.com/200/300"
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validate :image_size
  
  
  private
  
  def image_size
    if image.size > 5.megabytes
      errors.add(:picture, "must be less than 5MB.")
    end
  end

################################### The Last End ###################################  
end