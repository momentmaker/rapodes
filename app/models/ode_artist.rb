class OdeArtist < ActiveRecord::Base
  belongs_to :ode
  belongs_to :artist
end
