# Timeout.cr [![Build Status](https://travis-ci.org/hugoabonizio/timeout.cr.svg?branch=master)](https://travis-ci.org/hugoabonizio/timeout.cr)

Declarative timeout pattern for Crystal using ```select``` keyword.

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  timeout:
    github: hugoabonizio/timeout.cr
```


## Usage


```crystal
require "timeout"

ch = Channel(Int32).new

spawn do
  sleep 2
  ch.send 1
end

select
when value = ch.receive
  puts "Done!"
when Timeout.after(1.second)
  puts "Timeout!"
end
```


## Contributing

1. Fork it ( https://github.com/hugoabonizio/timeout.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [hugoabonizio](https://github.com/hugoabonizio) Hugo Abonizio - creator, maintainer
