# frozen_string_literal: true

require "test_helper"

class RickAndMortyTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RickAndMorty::VERSION
  end

  def test_fetch_all_characters
    VCR.use_cassette("characters") do
      assert_instance_of Array, RickAndMorty.characters
      assert_instance_of Hash, RickAndMorty.characters.first
    end
  end

  def test_fetch_character
    VCR.use_cassette("character") do
      assert_instance_of Hash, RickAndMorty.character(1)
    end
  end

  def test_fetch_all_episodes
    assert_instance_of Array, RickAndMorty.episodes
    assert_instance_of Hash, RickAndMorty.episodes.first
  end

  def test_fetch_episode
    assert_instance_of Hash, RickAndMorty.episode(1)
  end

  def test_fetch_all_locations
    assert_instance_of Array, RickAndMorty.locations
    assert_instance_of Hash, RickAndMorty.locations.first
  end

  def test_fetch_location
    assert_instance_of Hash, RickAndMorty.location(1)
  end
end
