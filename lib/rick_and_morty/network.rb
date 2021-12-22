# frozen_string_literal: true

require "net/http"
require_relative "network/uri_builder"
require_relative "network/serializer"
require_relative "network/response"
require_relative "network/client"

module RickAndMorty
  # This module handle all network calls, and it is agnostic for any endpoint type
  module Network
    # Default network error
    class Error < StandardError; end
    # Client error 4xx
    class ClientError < Error; end
    # Server error 5xx
    class ServerError < Error; end
  end
end
