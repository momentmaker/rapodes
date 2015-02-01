class Artist < ActiveRecord::Base
  has_many :ode_artists

  validates :external_id, presence: true
  validates :name, presence: true
end
