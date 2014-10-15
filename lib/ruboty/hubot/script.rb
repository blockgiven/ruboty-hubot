require 'mem'
require 'coffee-script'

module Ruboty
  module Hubot
    class Script
      def initialize(source_path)
        if File.extname(source_path).downcase == '.coffee'
          @source = CoffeeScript.compile(File.read(source_path), bare: true)
        else
          @source = File.read(source_path)
        end
      end

      def to_s
        @source.to_s
      end
    end
  end
end
