class Ode < ActiveRecord::Base
  has_many :ode_artists
  has_many :artists, through: :ode_artists

  validates :external_id, presence: true
  validates :title, presence: true
  validates :lyrics, presence: true
end
