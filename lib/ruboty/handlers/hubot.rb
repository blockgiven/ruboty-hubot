module Ruboty
  module Handlers
    class Hubot < Base
      on /.*/, name: 'respond', description: 'respond by hubot scripts'

      def respond(message)
        Ruboty::Hubot::Actions::Respond.new(message).call
      end
    end
  end
end
