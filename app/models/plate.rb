class Plate < ApplicationRecord
  belongs_to :place

  has_attached_file :picture, styles: { medium: "1040x508#", thumb: "520x254#" }, default_url: "/img/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

end
