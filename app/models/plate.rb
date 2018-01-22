class Plate < ApplicationRecord
  belongs_to :place

  has_attached_file :picture, styles: { medium: "1000x", thumb: "500x" }, default_url: "/img/:style/plate.jpg"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
end
