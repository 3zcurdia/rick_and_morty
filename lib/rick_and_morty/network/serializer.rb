# frozen_string_literal: true

require "json"

module RickAndMorty
  module Network
    # Abstract class to serialize any type of content
    class Serializer
      def call(_content)
        raise NoMethodError, "Serialize method is not implemented"
      end

      private

      attr_reader :content
    end

    # Serialize JSON contents
    class JSONSerializer < Serializer
      def call(content)
        JSON.parse(content, symbolize_names: true)
      rescue JSON::ParserError
        nil
      end
    end
  end
end
