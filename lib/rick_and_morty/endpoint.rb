# frozen_string_literal: true

module RickAndMorty
  class Endpoint
    def initialize
      @client = Client.new("https://rickandmortyapi.com/api/")
    end

    def all
      response = client.get(endpoint_name)
      range = (2..response.dig(:info, :pages))
      response[:results] + AsyncStream.new(range).sum do |page|
        list(page)
      end
    end

    def list(page = nil)
      client.get(endpoint_name, query: { page: page })[:results]
    end

    def find(id)
      client.get("#{endpoint_name}/#{id}")
    end

    private

    attr_reader :client

    def endpoint_name
      @endpoint_name ||= self.class.name.split("::")[-1].downcase
    end
  end
end
