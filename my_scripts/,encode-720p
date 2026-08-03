#!/usr/bin/env ruby

require 'pathname'

class EncodeTo720p
  def initialize(f_input)
    @f_input = Pathname.new(f_input).realpath
    raise "[EncodeTo720p] Not a video file: #{f_input}" if @f_input.directory?

    @f_output = @f_input.sub_ext('.avi')
    raise "[EncodeTo720p] Output exists: #{@f_output}" if @f_output.exist?
  end

  def run
    run_handbrake
  end

  def run_handbrake

    secs = 3*60*60
    args = [
      'HandBrakeCLI',
      '--preset="Fast 720p30"',
      # "--stop-at='seconds:#{secs}'",
      '--optimize',
      "-i '#{@f_input}'",
      "-o '#{@f_output}'"
    ]

    puts "┌─#{@f_input}"
    puts "┼─#{@f_output}"
    puts "└─#{args.join(' ')}"
      
    exec(args.join(' '))
  end
end


f_input = ARGV[0]
EncodeTo720p.new(f_input).run

