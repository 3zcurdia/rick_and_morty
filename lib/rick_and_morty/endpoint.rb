# frozen_string_literal: true

module RickAndMorty
  class Endpoint
    def initialize
      @client = Client.new("https://rickandmortyapi.com/api/")
    end

    def all
      response = client.get(endpoint_name)
      response[:results] + threaded_list(response.dig(:info, :pages)) { |page| list(page) }
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

    def threaded_list(max)
      (2..max).map do |page|
        Thread.new { yield(page) }
      end.map(&:value).inject(:+)
    end
  end
end
