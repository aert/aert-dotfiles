#!/usr/bin/env ruby

output = `docker system df --format '{{.Reclaimable}}'`.lines

puts "I:#{output[0].strip}  C:#{output[1].strip}  V:#{output[2].strip}"
