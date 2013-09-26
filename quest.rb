#!/usr/bin/env ruby

def parse_data(data)
  raise NotImplementedError
end

def run
  raise NotImplementedError
end

if $0 == __FILE__
  run
end
