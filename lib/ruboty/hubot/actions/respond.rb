module Ruboty
  module Hubot
    module Actions
      class Respond < Ruboty::Actions::Base
        class << self
          include Mem

          def scripts
            Dir.glob(File.join(Dir.pwd, 'scripts/*')).map do |path|
              Script.new(path)
            end
          end

          def robot
            robot = Robot.new
            scripts.each {|script| robot.load_script script }
            robot
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
