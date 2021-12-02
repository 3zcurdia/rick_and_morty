# frozen_string_literal: true

require_relative "rick_and_morty/version"
require_relative "rick_and_morty/client"
require_relative "rick_and_morty/character"

module RickAndMorty
  class Error < StandardError; end
  class ClientError < Error; end
  class ServerError < Error; end

  def self.characters
    Character.new.list
  end

  def self.character(id)
    Character.new.find(id)
  end

  def self.locations
    [{}]
  end

  def self.location(_id)
    {}
  end

  def self.episodes
    [{}]
  end

  def self.episode(_id)
    {}
  end
end
