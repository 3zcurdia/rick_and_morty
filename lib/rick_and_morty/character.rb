# frozen_string_literal: true

module RickAndMorty
  class Character
    def initialize
      @client = Client.new("https://rickandmortyapi.com/api/")
    end

    def all
      response = client.get("character")
      results = response[:results]
      (2..response[:info][:pages]).map do |page|
        results += list(page)
      end
      results
    end

    def list(page = nil)
      client.get("character", query: { page: page })[:results]
    end

    def find(id)
      client.get("character/#{id}")
    end

    private

    attr_reader :client
  end
end
