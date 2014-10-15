module Ruboty
  module Handlers
    class Hubot < Base
      on /.*/, name: 'hear',    description: 'respond by hubot scripts', all: true
      on /.*/, name: 'respond', description: 'respond by hubot scripts'

      def hear(message)
        Ruboty::Hubot::Actions::Hear.new(message).call
      end

      def respond(message)
        Ruboty::Hubot::Actions::Respond.new(message).call
      end
    end
  end
end
