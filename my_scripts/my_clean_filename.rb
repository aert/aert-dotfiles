#!/usr/bin/env ruby

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

class UselessFilesRemover
  include WithSay

  IGNORE = [
    'visit for more books.txt',
    'tutsgalaxy com.txt',
    'www yts ag.jpg',
    'bookflare net.txt',
    'free audiobook version.txt',
    'www yify-torrents com.jpg'
  ].freeze

  def initialize(simulate = true)
    @simulate = simulate
    say "UselessFilesRemover: #{simulate ? 'simulate only' : 'force run'}"
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
      if p.directory? then process_dir(p)
      elsif p.file? then process_file(p)
      end
    end
  end

  def process_file(path)
    basename = path.basename.to_s
    return unless IGNORE.include?(basename.downcase)

    say path.to_s, true
    return if @simulate

    FileUtils.rm path
  end
end

class OneFileDirToFileHandler
  include WithSay

  def initialize(simulate = true)
    @simulate = simulate
    say "OneFileDirToFileHandler: #{simulate ? 'simulate only' : 'force run'}"
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

    process_dir(path, true)
  end

  def process_dir(path, is_root_dir = false)
    return if IGNORE_DIRS.include?(path.basename.to_s)
    path.each_child do |p|
      process_dir(p) if p.directory?
    end

    return if is_root_dir

    files = path.children.select(&:file?)
    return unless files.size == 1

    process_file(files[0])
  end

  def process_file(path)
    ext = path.extname
    basename = path.basename('.*').to_s
    dir_basename = path.dirname.basename.to_s
    new_name = basename.size >= dir_basename.size ? basename : dir_basename
    new_name += ext
    new_path = (path.dirname + "../#{new_name}").cleanpath

    puts "┌─#{path}"
    puts "└─#{new_path}"
    return if @simulate

    FileUtils.mv path, new_path
  end
end

class EmptyDirRemover
  include WithSay

  def initialize(simulate = true)
    @simulate = simulate
    say "EmptyDirRemover: #{simulate ? 'simulate only' : 'force run'}"
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

    process_dir(path, true)
  end

  def process_dir(path, is_root_dir = false)
    return if IGNORE_DIRS.include?(path.basename.to_s)
    path.each_child do |p|
      process_dir(p) if p.directory?
    end

    return if is_root_dir
    return unless path.children.size.zero?

    remove_dir(path)
  end

  def remove_dir(path)
    say path.to_s, true
    return if @simulate

    FileUtils.rmdir path
  end
end

class FilenameCleaner
  include WithSay

  IGNORE_WORDS = %w[
    x264
    epub pdf
    mp3 flac ogg
    blueray bluray avi hdrip dvdrip webm webrip brrip yify
  ].freeze

  def initialize(simulate = true)
    @simulate = simulate
    say "FilenameCleaner: #{simulate ? 'simulate only' : 'force run'}"
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
    orig, cleaned, dest = clean(path, true)

    if orig != cleaned
      display(orig, cleaned, dest)
      return if @simulate

      FileUtils.mv path, dest
      path = dest
    end

    path.each_child do |p|
      if p.directory? then process_dir(p)
      elsif p.file? then process_file(p)
      else
        say "#{p}: not a regular file", false, 0, 0, true
      end
    end
  end

  def process_file(path)
    orig, cleaned, dest = clean(path)
    return unless orig != cleaned

    display(orig, cleaned, dest)
    return if @simulate

    FileUtils.mv path, dest
  end

  def clean(path, is_dir = false)
    ext = is_dir ? '' : path.realpath.extname
    orig = path.realpath.basename(is_dir ? '' : '.*').to_s
    cleaned = orig.tr('[{', '(')
                  .tr(']}', ')')
                  .gsub(/\b\.$|\b\.\b/, '-') # dots in middle
                  .gsub(/\(.*\)/, '')
                  .gsub(/[^'_\-\p{Alnum}\p{Arabic}]/i, ' ')
                  .gsub(/ \d+p/, '') # 720p
    IGNORE_WORDS.each do |w|
      cleaned.gsub!(/^#{w}\b|\b#{w}$|\b#{w}\b/i, '')
    end
    cleaned = cleaned.squeeze(' ')
                     .strip
                     .gsub(/^\-+|^\_|\-+$|\_+$\)/, '')
                     .strip
    cleaned += ext

    [
      orig + ext,
      cleaned,
      (path.realpath.dirname + cleaned).cleanpath
    ]
  end

  def display(orig, cleaned, dest)
    puts "┌─#{orig.to_s.tr("\r", ' ')}"
    puts "┼─#{cleaned}"
    puts "└─#{dest}"
  end
end

sim = !ARGV.include?('-f')
params = ARGV.reject { |s| s == '-f' }
FilenameCleaner.new(sim).walk_dirs(params)
UselessFilesRemover.new(sim).walk_dirs(params)
OneFileDirToFileHandler.new(sim).walk_dirs(params)
EmptyDirRemover.new(sim).walk_dirs(params)