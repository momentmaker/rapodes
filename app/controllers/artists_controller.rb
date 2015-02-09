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
    @artist = Artist.new({external_id: ode.artist.response["id"], name: ode.artist.name})
    if @artist.save
      redirect_to root_path, notice: "#{@artist.name} was added."
    else
      render root_path, alert: "Sorry, I can't find any artist."
    end
  end

  private

  def artist_params
    params.require(:artist).permit(:name)
  end
end
