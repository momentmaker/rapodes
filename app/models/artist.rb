class Artist < ActiveRecord::Base
  has_many :ode_artists
  has_many :odes, through: :ode_artists

  validates :external_id, presence: true
  validates :name, presence: true
end
