require 'mem'
require 'execjs'
require "open-uri"

module Ruboty
  module Hubot
    class Script
      class << self
        include Mem

        def compile(source)
          coffee.call("CoffeeScript.compile", source, bare: true)
        end

        private

        def coffee
          ExecJS.compile(coffee_source)
        end
        memoize :coffee

        def coffee_source
          open("http://coffeescript.org/extras/coffee-script.js").read
        end
        memoize :coffee_source
      end

      def initialize(source_path)
        if File.extname(source_path).downcase == '.coffee'
          @source = self.class.compile(File.read(source_path))
        else
          @source = File.read(source_path)
        end
      end

      def to_s
        @source
      end
    end
  end
end
