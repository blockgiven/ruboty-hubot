module Ruboty
  module Hubot
    module Actions
      class Respond < Ruboty::Actions::Base
        class << self
          include Mem

          def robot
            Robot.new
          end
          memoize :robot
        end

        def call
          self.class.robot.receive(message.body) do |res|
            message.reply("@#{message.from_name} #{res}")
          end
        end
      end
    end
  end
end
