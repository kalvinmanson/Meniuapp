class Place < ApplicationRecord

  before_create :make_slug

  belongs_to :user
  belongs_to :category
  has_many :plates
  has_many :visits, through: :plates
  has_many :votes
  has_many :quests, :foreign_key => "visited_place"

  has_attached_file :cover, styles: { medium: "1500x500#", thumb: "750x250#" }, default_url: "/img/:style/cover.jpg"
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/

  has_attached_file :avatar, styles: { medium: "400x400#", thumb: "100x100#" }, default_url: "/img/:style/avatar.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_attached_file :logo, styles: { medium: "150x120#", thumb: "40x30#" }, default_url: "/img/:style/logo.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  acts_as_mappable

  def make_slug
    self.slug = self.name.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
  end


end
