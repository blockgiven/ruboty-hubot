require 'execjs'

module Ruboty
  module Hubot
    class Robot
      include Mem

      def initialize
        @scripts = []
      end

      def load_script(script)
        @scripts << script
      end

      def receive(text)
        if res_text = robot_context.call("ruboty.receive", text)
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
var module = {};

#{@scripts.join(";\n")}

var ruboty = {
  handlers: [],
  respond: function (regexp, callback) {
    ruboty.handlers.push({
      response: function (text) {
        var match;
        if (match = text.match(regexp)) {
          var res = {
            match: match,
            sentText: null,
            send: function (text) { return res.sentText = text; }
          };
          return res;
        }
      },
      callback: callback
    });
  },

  // all
  hear: undefined,

  // mention
  receive: function (text) {
    var i, len, res;
    for (i = 0, len = ruboty.handlers.length; i < len; i++) {
      if (res = ruboty.handlers[i].response(text)) {
        return ruboty.handlers[i].callback(res);
      }
    }
    return undefined;
  }
};

module.exports(ruboty);
ROBOT_JS
      end
    end
  end
end
