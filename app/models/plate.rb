class Plate < ApplicationRecord
  belongs_to :place
  has_many :visits
  has_many :quests, :foreign_key => "visited_plate"

  has_attached_file :picture, styles: { medium: "1000x", thumb: "500x" }, default_url: "/img/:style/plate.jpg"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  acts_as_mappable :through => :place
end
