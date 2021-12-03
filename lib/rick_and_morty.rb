# frozen_string_literal: true

require "json"
require_relative "rick_and_morty/version"
require_relative "rick_and_morty/async_stream"
require_relative "rick_and_morty/client"
require_relative "rick_and_morty/endpoint"
require_relative "rick_and_morty/character"
require_relative "rick_and_morty/location"
require_relative "rick_and_morty/episode"

module RickAndMorty
  class Error < StandardError; end
  class ClientError < Error; end
  class ServerError < Error; end

  def self.characters
    Character.new.all
  end

  def self.character(id)
    Character.new.find(id)
  end

  def self.locations
    Location.new.all
  end

  def self.location(id)
    Location.new.find(id)
  end

  def self.episodes
    Episode.new.all
  end

  def self.episode(id)
    Episode.new.find(id)
  end
end
