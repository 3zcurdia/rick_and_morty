# frozen_string_literal: true

require "json"
require "net/http"

module RickAndMorty
  class Client
    def initialize(base_url)
      @base_url = base_url
    end

    def get(path)
      request(path) do |uri|
        Net::HTTP::Get.new(uri)
      end
    end

    # def post(path, data = {})
    #   request(path) do |uri|
    #     Net::HTTP::Post.new(uri)
    #   end
    # end
    #
    # def put(path, data = {})
    #   request(path) do |uri|
    #     Net::HTTP::Put.new(uri)
    #   end
    # end
    #
    # def delete(path)
    #   request(path) do |uri|
    #     Net::HTTP::Delete.new(uri)
    #   end
    # end

    private

    attr_reader :base_url

    def request(path)
      uri = URI.join(base_url, path)
      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        request = yield(uri)
        handle(http.request(request))
      end
    end

    def handle(request)
      case request
      when Net::HTTPSuccess
        parse_json(request.body)
      when Net::HTTPClientError
        raise ClientError, "[#{request.code}] Client error"
      when Net::HTTPServerError
        raise ServerError, "[#{request.code}] Server error"
      end
    end

    def parse_json(content)
      JSON.parse(content, symbolize_names: true)
    rescue JSON::ParserError
      nil
    end
  end
end
