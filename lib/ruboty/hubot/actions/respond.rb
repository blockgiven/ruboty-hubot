module Ruboty
  module Hubot
    module Actions
      class Respond < Ruboty::Actions::Base
        def call
          Robot.instance.receive_mention(message.body) do |res|
            message.reply(res)
          end
        end
      end
    end
  end
end
