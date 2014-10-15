module Ruboty
  module Hubot
    module Actions
      class Hear < Ruboty::Actions::Base
        def call
          Robot.instance.receive_all(message.body) do |res|
            message.reply(res)
          end
        end
      end
    end
  end
end
