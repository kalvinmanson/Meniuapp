class Quest < ApplicationRecord
  belongs_to :user

  acts_as_mappable
end
