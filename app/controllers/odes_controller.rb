class OdesController < ApplicationController
  rescue_from RapGenius::NotFoundError, with: :not_found

  def index
    if params[:artists].length > 0
      artists = []
      lyrics = []
      selected = params[:artists].split(',')
      selected.each do |name|
        artists << Artist.find_by(name: name)
      end
      artists.each do |artist|
        lyrics << fetch_lyrics(artist)
      end
      @odes = fetch_topic(params[:search], lyrics)
    elsif params[:search]
      @odes = fetch_topic(params[:search], lyrics)
      render :index
    else
      redirect_to root_path, flash[:alert] = "Error. Try again."
    end
  end

  private

  def fetch_lyrics(artist)
    lyrics = []
    artist.odes.each do |ode|
      lyrics << ode.lyrics if ode.lyrics
    end
    lyrics
  end

  def fetch_topic(topic, lyrics)
    @odes = []
    if lyrics.any?
      lyrics.each do |lyric|
        unless lyric.is_a? Array
          if lyric.downcase.include? topic.downcase
            @odes << lyric
          end
        end
      end
      trim_odes_list(@odes)
    else
      odes_list = RapGenius.search_by_lyrics(topic)
      trim_odes_list(odes_list)
      odes_list.each do |ode|
        @odes << RapGenius::Song.find(ode.id)
      end
      filter_odes
    end
  end

  def trim_odes_list(list)
    while list.length > 9
      list.delete(list.sample)
    end
    list
  end

  def filter_odes
    @odes.map {|ode| {id: ode.id, title: ode.title, lyrics: ode.document["response"]["song"]["lyrics"]["plain"]}}
  end
end
