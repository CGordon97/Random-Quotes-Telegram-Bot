require 'net/http'
require 'json'
require './lib/random_parser.rb'

class RickAndMortyQuoter
  def initialize
    file = File.read('./quotes/rick_and_morty.json')
    @parser = RandomParser.new(file)
  end

  def quote(id)
    quote =
      if id
        matches = quotes.select { |quote| quote['id'] == id }
        return 'Sorry, there is no qoute with that id' if matches.empty?
        matches[0]
      else
        @parser.random_entry
      end

    <<-QUOTE
    #{quote['what']}
      - #{quote['who']} (#{quote['when']}, quote: #{quote['id'] || 'fallback'})
    QUOTE
  end

  def self.quote(id)
    new.quote(id)
  end

  def self.start
    'Wubba Lubba Dub Dub'
  end

  private

    def quotes
      @quotes ||= @parser.quotes
    end
end
