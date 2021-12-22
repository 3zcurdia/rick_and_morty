# frozen_string_literal: true

module RickAndMorty
  module Network
    # Requests and responses orquestator
    class Client
      def initialize(base_url, serializer: JSONSerializer.new)
        @uri_builder = UriBuilder.new(base_url)
        @serializer = serializer
      end

      def get(path, **args)
        request(path, **args) { |uri| Net::HTTP::Get.new(uri) }
      end

      def post(path, **_args)
        request(path) do |uri|
          Net::HTTP::Post.new(uri)
        end
      end

      def put(path, **args)
        request(path, **args) do |uri|
          Net::HTTP::Put.new(uri)
        end
      end

      def delete(path, **args)
        request(path, **args) { |uri| Net::HTTP::Delete.new(uri) }
      end

      private

      attr_reader :uri_builder, :serializer

      def request(path, **args)
        uri = uri_builder.build(path, **args)
        net_response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
          request = yield(uri)
          http.request(request)
        end
        Response.handle(net_response, serializer: serializer)
      end
    end
  end
end
