# frozen_string_literal: true

require_relative "rick_and_morty/version"
require_relative "rick_and_morty/client"

module RickAndMorty
  class Error < StandardError; end
  class ClientError < Error; end
  class ServerError < Error; end

  def self.characters
    [{}]
  end

  def self.character(_id)
    {}
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
