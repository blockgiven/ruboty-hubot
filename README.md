# Ruboty::Hubot

ruboty plugin for using hubot script in ruboty.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-hubot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruboty-hubot

## Usage

put your hubot scripts under the `scripts`

### Example:

``` js
module.exports = function(robot) {
  return robot.respond(/yo$/i, function(res) {
    return res.send('yo!');
  });
};
```

## TODO

- [x] support `.js` scripts
- [x] support `.coffee` scripts
- [x] support robot.respond
- [x] support robot.hear
- [ ] support more complex methods (e.x. robot.http)
- [ ] support `external-scripts.json`
- [ ] support `hubot-scripts.json`

## Contributing

1. Fork it ( https://github.com/blockgiven/ruboty-hubot/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
