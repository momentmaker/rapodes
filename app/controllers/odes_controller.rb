class OdesController < ApplicationController
  rescue_from RapGenius::NotFoundError, with: :not_found

  def index
    if params[:search]
      @odes = fetch_topic(params[:search])
      render :index
    else
      redirect_to root_path, flash[:alert] = "Error. Try again."
    end
  end

  private

  def fetch_topic(topic)
    @odes = []
    odes_list = RapGenius.search_by_lyrics(topic)
    11.times do
      odes_list.delete(odes_list.sample)
    end
    odes_list.each do |ode|
      @odes << RapGenius::Song.find(ode.id)
    end
    filter_odes
  end

  def filter_odes
    @odes.map {|ode| {id: ode.id, title: ode.title, lyrics: ode.document["response"]["song"]["lyrics"]["plain"]}}
  end
end
