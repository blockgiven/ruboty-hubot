module Ruboty
  module Hubot
    class Script
      # TODO: compile .coffee
      def initialize(source_path)
        @source = File.read(source_path)
      end

      def to_s
        @source
      end
    end
  end
end
