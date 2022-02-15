# frozen_string_literal: true

class Curator
  attr_reader :photographs, :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist.id == id
    end
  end

  def photographs_by_artist
    photographs_by_artist = {}
    @artists.each do |artist|
      photographs_by_artist[artist] = [] if photographs_by_artist[artist].nil?
      @photographs.each do |photo|
        photographs_by_artist[artist] << photo if photo.artist_id == artist.id
      end
    end
    photographs_by_artist
  end

  def artists_with_multiple_photographs
    multiples = []
    photographs_by_artist.each do |artist, photo|
      multiples << artist.name if photo.length >= 2
    end
    multiples
  end

  def photographs_taken_by_artist_from(location)
    photos = []
    photographs_by_artist.find_all do |artist, photo|
      photos << photo if artist.country == location
    end
    photos
  end
end
