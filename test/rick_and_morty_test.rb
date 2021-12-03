# frozen_string_literal: true

require "test_helper"

class RickAndMortyTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RickAndMorty::VERSION
  end

  def test_fetch_all_characters
    VCR.use_cassette("all_characters") do
      characters = RickAndMorty.characters
      assert_instance_of Array, characters
      assert_instance_of Hash, characters.first
    end
  end

  def test_fetch_character
    VCR.use_cassette("character") do
      assert_instance_of Hash, RickAndMorty.character(1)
    end
  end

  def test_fetch_all_episodes
    VCR.use_cassette("all_episodes") do
      assert_instance_of Array, RickAndMorty.episodes
      assert_instance_of Hash, RickAndMorty.episodes.first
    end
  end

  def test_fetch_episode
    VCR.use_cassette("episode") do
      assert_instance_of Hash, RickAndMorty.episode(1)
    end
  end

  def test_fetch_all_locations
    VCR.use_cassette("all_locations") do
      assert_instance_of Array, RickAndMorty.locations
      assert_instance_of Hash, RickAndMorty.locations.first
    end
  end

  def test_fetch_location
    VCR.use_cassette("location") do
      assert_instance_of Hash, RickAndMorty.location(1)
    end
  end
end
