# frozen_string_literal: true

module RickAndMorty
  class AsyncStream
    def initialize(enumerable)
      @enumerable = enumerable
    end

    def map
      enumerable.map do |item|
        Thread.new { yield(item) }
      end.map(&:value)
    end

    def sum(&block)
      map(&block).inject(:+)
    end

    private

    attr_reader :enumerable
  end
end
