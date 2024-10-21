#!/usr/bin/env ruby

require 'pathname'

class MyScanClean
  def initialize(f_input)
    @f_input = Pathname.new(f_input).realpath
    raise "[MyScanClean] Not a scan file: #{f_input}" if @f_input.directory?

    @f_output = @f_input.sub_ext('-cleaned.jpg')
    raise "[MyScanClean] Output exists: #{@f_output}" if @f_output.exist?
  end

  def run
    args = [
      'convert', '-type', 'grayscale',
      '-gamma', '2',
      '-normalize', '-contrast -contrast -contrast',
      @f_input, @f_output
    ]

    puts "┌─#{@f_input}"
    puts "┼─#{@f_output}"
    puts "└─#{args.join(' ')}"

    exec(args.join(' '))
  end
end

f_input = ARGV[0]
MyScanClean.new(f_input).run
