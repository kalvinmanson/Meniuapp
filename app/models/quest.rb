class Quest < ApplicationRecord
  belongs_to :user
  belongs_to :place, :foreign_key => "visited_place"
  belongs_to :plate, :foreign_key => "visited_plate"

  acts_as_mappable
end
