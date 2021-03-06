require 'execjs'
require 'singleton'

module Ruboty
  module Hubot
    class Robot
      include Mem
      include Singleton

      def receive_all(text)
        if res_text = robot_context.call("ruboty.receiveAll", text)
          yield res_text if block_given?
        end
      end

      def receive_mention(text)
        if res_text = robot_context.call("ruboty.receiveMention", text)
          yield res_text if block_given?
        end
      end

      private

      def robot_context
        ExecJS.compile(robot_js)
      end
      memoize :robot_context

      def robot_js
        @robot_js = <<ROBOT_JS
var ruboty = {
  // mention
  respondHandlers: [],

  respond: function (regexp, callback) {
    ruboty.respondHandlers.push({
      regexp: regexp,
      callback: callback
    });
  },

  receiveMention: function (text) {
    return ruboty.receive(text, ruboty.respondHandlers);
  },

  // all
  hearHandlers: [],

  hear: function (regexp, callback) {
    ruboty.hearHandlers.push({
      regexp: regexp,
      callback: callback
    });
  },

  receiveAll: function (text) {
    return ruboty.receive(text, ruboty.hearHandlers);
  },

  receive: function (text, handlers) {
    var i, len, match, message;
    for (i = 0, len = handlers.length; i < len; i++) {
      if (match = text.match(handlers[i].regexp)) {
        message = {
          match: match,
          sentText: null,
          send: function (text) { return message.sentText = text; }
        };
        handlers[i].callback(message);
        return message.sentText;
      }
    }
    return undefined;
  }
};
var module = {};
#{scripts.map {|s| "#{s}\nif (module.exports) { module.exports(ruboty); module.exports = undefined; }\n" }.join("\n")}

ROBOT_JS
      end

      def scripts
        Dir.glob(File.join(Dir.pwd, 'scripts/*')).map do |path|
          Script.new(path)
        end
      end
    end
  end
end
