module Ruboty
  module Hubot
    module Actions
      class Respond < Ruboty::Actions::Base
        def call
          Robot.instance.receive(message.body) do |res|
            message.reply("@#{message.from_name} #{res}")
          end
        end
      end
    end
  end
end
