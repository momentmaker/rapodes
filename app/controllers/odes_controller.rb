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
    odes_list.each do |ode|
      find_ode = RapGenius::Song.find(ode.id)
      lyrics = find_ode.document["response"]["song"]["lyrics"]["plain"]
      if lyrics.lines.count < 80 && lyrics.lines.first.length < 120 && lyrics.lines.last.length < 120
        @odes << find_ode
      end
    end
    while @odes.length > 9
      @odes.delete(@odes.sample)
    end
    filter_odes
  end

  def filter_odes
    @odes.map {|ode| {id: ode.id, title: ode.title, lyrics: ode.document["response"]["song"]["lyrics"]["plain"]}}
  end
end
