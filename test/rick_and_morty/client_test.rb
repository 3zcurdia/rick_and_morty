# frozen_string_literal: true

require "test_helper"

module RickAndMorty
  class ClientTest < Minitest::Test
    def client
      Client.new("https://rickandmortyapi.com/api/")
    end

    def test_client_class_must_exist
      refute_nil Client.new("https://example.com")
    end

    def test_client_must_raise_an_exception_when_path_missing
      VCR.use_cassette("client_error") do
        assert_raises ClientError do
          client.get("bad_uri")
        end
      end
    end

    def test_client_must_get_all_characters
      VCR.use_cassette("characters") do
        assert_instance_of Hash, client.get("character")
        assert_instance_of Array, client.get("character")[:results]
      end
    end

    def test_client_must_get_character
      VCR.use_cassette("character") do
        assert_instance_of Hash, client.get("character/1")
      end
    end
  end
end
