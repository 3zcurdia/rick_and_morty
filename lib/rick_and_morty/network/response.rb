# frozen_string_literal: true

module RickAndMorty
  module Network
    # Encapsulate network responses and orchestrate content serialization
    class Response
      def self.handle(http_response, serializer:)
        new(http_response, serializer: serializer).handle
      end

      def initialize(http_response, serializer:)
        @http_response = http_response
        @serializer = serializer
      end

      def handle
        case http_response
        when Net::HTTPSuccess
          serializer.call(http_response.body)
        when Net::HTTPClientError
          raise ClientError, "[#{http_response.code}] #{http_response.class}"
        when Net::HTTPServerError
          raise ServerError, "[#{http_response.code}] #{http_response.class}"
        end
      end

      private

      attr_reader :http_response, :serializer
    end
  end
end
