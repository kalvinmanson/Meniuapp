class Visit < ApplicationRecord
  belongs_to :user
  belongs_to :plate
  has_one :places, through: :plates
end
