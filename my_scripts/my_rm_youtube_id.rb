#!/usr/bin/env ruby

# Requirements:
#
# - gem install activesupport

require 'pathname'
require 'fileutils'

IGNORE_DIRS = [
  '.svn', '.git'
].freeze

module WithSay
  def say(message, subitem = false, count = 0, index = 0, error = false, subitem_level = 1)
    msg = nil
    subitem_prefix = if subitem
                       ('   ' * subitem_level) + (subitem_level > 1 ? '  -' : '->')
                     end

    if subitem && (count > 0 || index > 0)
      count_str = count.zero? ? '?' : count.to_s
      index_str = format("%#{count_str.length}d", index + 1)

      msg = "#{subitem_prefix} [#{index_str}/#{count_str}] #{error ? '[ERROR] ' : ''}#{message}"
    else
      msg = "#{subitem ? subitem_prefix : '--'} #{message}"
    end

    puts msg
  end

  def say_with_time(message = '')
    say(message)
    result = nil
    time = Benchmark.measure { result = yield }
    say format('%.4fs (duration)', time.real), true
    say("#{result} modifications", true) if result.is_a?(Integer)
    result
  end
end

class YoutubeIdRenamer
  include WithSay

  ALLOWED_EXT = %w[
    .mp3 .mp4 .m4v
  ].freeze

  def initialize(simulate = true)
    @simulate = simulate
    say "YoutubeIdRenamer: #{simulate ? 'simulate only' : 'force run'}"
  end

  def walk_dirs(paths = [])
    paths.each { |p| walk_dir(Pathname.new(p)) }
  end

  private

  def walk_dir(path)
    unless path.directory?
      say "Not a directory: #{path}", false, 0, 0, true
      return
    end

    process_dir(path)
  end

  def process_dir(path)
    return if IGNORE_DIRS.include?(path.basename.to_s)

    path.each_child do |p|
      process_file(p) if p.file? && ALLOWED_EXT.include?(p.extname)
    end
  end

  def process_file(path)
    return unless path.realpath.basename('.*').to_s.rindex('-')

    orig, cleaned, dest = clean(path)
    return unless orig != cleaned

    display(orig, cleaned, dest)
    return if @simulate

    FileUtils.mv path, dest
  end

  def clean(path)
    ext = path.realpath.extname
    orig = path.realpath.basename('.*').to_s
    cleaned = orig[0, orig.rindex('-')]
    cleaned = cleaned.squeeze(' ').squeeze('-').strip + ext

    [orig + ext, cleaned, (path.realpath.dirname + cleaned).cleanpath]
  end

  def display(orig, cleaned, dest)
    puts "┌─#{orig.to_s.tr("\r", ' ')}"
    puts "┼─#{cleaned}"
    puts "└─#{dest}"
  end
end

sim = !ARGV.include?('-f')
params = ARGV.reject { |s| s == '-f' }
YoutubeIdRenamer.new(sim).walk_dirs(params)
