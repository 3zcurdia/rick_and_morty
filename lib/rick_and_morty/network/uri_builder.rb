# frozen_string_literal: true

module RickAndMorty
  module Network
    # Handle uri constructions
    class UriBuilder
      def initialize(base_url)
        @base_url = base_url
      end

      def build(path, **options)
        uri = URI.join(base_url, path)
        uri.query = query_items(**options)
        yield if block_given?
        uri
      end

      private

      attr_reader :base_url

      def query_items(**options)
        query_items = options.fetch(:query, {}).compact
        URI.encode_www_form(query_items)
      end
    end
  end
end
