class ArtistsController < ApplicationController
  rescue_from RapGenius::NotFoundError, with: :not_found

  def index
    @artists = Artist.all
  end

  def create
    odes = RapGenius::search_by_artist(artist_params)
    ode = nil
    odes.each do |o|
      ode = o if o.artist.name.downcase.include? artist_params[:name].downcase
    end
    ode = odes.first if ode == nil
    existing_artist = Artist.where("external_id = ?", ode.artist.response["id"])
    if existing_artist.first
      redirect_to root_path, alert: "This artist already exist in the database."
    else
      @artist = Artist.new({external_id: ode.artist.response["id"], name: ode.artist.name})
      if @artist.save
        create_odes_by(ode.artist)
        redirect_to root_path, notice: "#{@artist.name} was added plus all of their songs!"
      else
        render root_path, alert: "Sorry, I can't find any artist."
      end
    end
  end

  private

  def create_odes_by(artist)
    n = 1
    while artist.songs(page: n).length > 0
      artist.songs(page: n).each do |song|
        fetch_song(song)
        OdeArtist.create(ode_id: song.id, artist_id: @artist.id)
      end
      n += 1
    end
  end

  def fetch_song(song)
    ode = RapGenius::Song.find(song.id)
    Ode.create_with(title: song.title, lyrics: ode.document["response"]["song"]["lyrics"]["plain"]).find_or_create_by(external_id: song.id)
  end

  def artist_params
    params.require(:artist).permit(:name)
  end
end
