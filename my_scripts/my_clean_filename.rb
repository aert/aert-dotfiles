#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'activesupport', '~> 7.0'
end

require 'pathname'
require 'fileutils'
require 'benchmark'
require 'optparse'
require 'active_support/inflector'

IGNORE_DIRS = %w[.svn .git].freeze

#-- WithSay ----------------------------------------------------------------{{{

module WithSay
  def say(message, subitem: false, count: 0, index: 0, error: false, subitem_level: 1)
    prefix = if subitem
               indent = '   ' * subitem_level
               arrow = subitem_level > 1 ? '  -' : '->'
               "#{indent}#{arrow}"
             else
               '--'
             end

    msg = if subitem && (count.positive? || index.positive?)
            count_str = count.zero? ? '?' : count.to_s
            index_str = format("%#{count_str.length}d", index + 1)
            "#{prefix} [#{index_str}/#{count_str}] #{'[ERROR] ' if error}#{message}"
          else
            "#{prefix} #{message}"
          end

    puts msg
  end

  def say_with_time(message = '')
    say(message)
    result = nil
    time = Benchmark.measure { result = yield }
    say format('%.4fs (duration)', time.real), subitem: true
    say("#{result} modifications", subitem: true) if result.is_a?(Integer)
    result
  end
end

#-- WithSay ----------------------------------------------------------------}}}

#-- BaseProcessor ----------------------------------------------------------{{{

class BaseProcessor
  include WithSay

  def initialize(simulate: true)
    @simulate = simulate
    say "#{self.class.name}: #{simulate ? 'simulate only' : 'force run'}"
  end

  def walk_dirs(paths)
    paths.each { |p| walk_dir(Pathname.new(p)) }
  end

  private

  def walk_dir(path)
    unless path.directory?
      say "Not a directory: #{path}", error: true
      return
    end

    process_dir(path, is_root_dir: true)
  end

  def process_dir(path, is_root_dir: false)
    return if IGNORE_DIRS.include?(path.basename.to_s)

    before_children(path, is_root_dir:)

    path.each_child do |child|
      process_entry(child, is_root_dir:)
    end

    after_children(path, is_root_dir:)
  end

  # Hook: called before iterating children (override in subclass)
  def before_children(_path, is_root_dir:); end

  # Hook: called for each child entry (override in subclass)
  def process_entry(_child, is_root_dir:); end

  # Hook: called after all children processed (override in subclass)
  def after_children(_path, is_root_dir:); end
end

#-- BaseProcessor ----------------------------------------------------------}}}

#-- UselessFilesRemover ----------------------------------------------------{{{

class UselessFilesRemover < BaseProcessor
  REMOVE_NAMES = [
    'visit for more books.txt',
    'tutsgalaxy com.txt',
    'bookflare net.txt',
    'free audiobook version.txt'
  ].freeze

  REMOVE_PATTERNS = [
    /downloaded from.*\.txt$/i,
    /.*torrent.downloaded.*/i,
    /.*torrents com.*/i,
    /.*\.url$/i,
    /^wwrg.*/i,
    /^source\.txt$/i,
    /^www yts.*\.jpg$/i,
    /^www yify.*\.jpg$/i,
    /^more books audio.*\.txt$/i,
    /^ahashare.*\.txt$/i
  ].freeze

  private

  def process_entry(child, is_root_dir:)
    if child.directory?
      process_dir(child)
    elsif child.file?
      process_file(child)
    end
  end

  def process_file(path)
    basename = path.basename.to_s.downcase
    should_delete = REMOVE_NAMES.include?(basename) ||
                    REMOVE_PATTERNS.any? { |pattern| pattern.match?(path.basename.to_s) }
    return unless should_delete

    say path.to_s, subitem: true
    FileUtils.rm(path) unless @simulate
  end
end

#-- UselessFilesRemover ----------------------------------------------------}}}

#-- OneFileDirToFileHandler ------------------------------------------------{{{

class OneFileDirToFileHandler < BaseProcessor
  private

  def process_entry(child, is_root_dir:)
    process_dir(child) if child.directory?
  end

  def after_children(path, is_root_dir:)
    return if is_root_dir

    files = path.children.select(&:file?)
    return unless files.size == 1

    move_single_file(files.first, path)
  end

  def move_single_file(file_path, dir_path)
    ext = file_path.extname
    file_basename = file_path.basename('.*').to_s
    dir_basename = dir_path.basename.to_s
    new_name = file_basename.size >= dir_basename.size ? file_basename : dir_basename
    new_path = (dir_path.dirname / "#{new_name}#{ext}").cleanpath

    puts "┌─#{file_path}"
    puts "└─#{new_path}"
    FileUtils.mv(file_path, new_path) unless @simulate
  end
end

#-- OneFileDirToFileHandler ------------------------------------------------}}}

#-- EmptyDirRemover --------------------------------------------------------{{{

class EmptyDirRemover < BaseProcessor
  private

  def process_entry(child, is_root_dir:)
    process_dir(child) if child.directory?
  end

  def after_children(path, is_root_dir:)
    return if is_root_dir
    return unless path.children.empty?

    say path.to_s, subitem: true
    FileUtils.rmdir(path) unless @simulate
  end
end

#-- EmptyDirRemover --------------------------------------------------------}}}

#-- FilenameCleaner --------------------------------------------------------{{{

class FilenameCleaner < BaseProcessor
  IGNORE_WORDS = %w[
    h264 x264 x265 720p 1080p 4k uhd
    epub pdf
    mp3 flac ogg
    blueray bluray avi hdtv hdrip dvdrip webm webrip brrip yify xvid evo ac3
    imax bdrip
    galaxytv galaxyrg wrcr tbs deflate minx 800mb phoenix torrentgalaxy
    web-dl aac-hhweb
    neonoir elite ddp5
  ].freeze

  FRENCH_WORDS = %w[truefrench french].freeze
  SPECIAL_WORDS = %w[-extreme].freeze

  private

  def before_children(path, is_root_dir:)
    orig, cleaned, dest = clean(path, is_dir: true)
    return if orig == cleaned

    display(orig, cleaned, dest)
    return if @simulate

    FileUtils.mv(path, dest)
    # Update path reference for child processing would require returning new path
    # but we process children from the original path object which is now moved
  end

  def process_entry(child, is_root_dir:)
    if child.directory?
      process_dir(child)
    elsif child.file?
      process_file(child)
    else
      say "#{child}: not a regular file", error: true
    end
  end

  def process_file(path)
    orig, cleaned, dest = clean(path)
    return if orig == cleaned

    display(orig, cleaned, dest)
    FileUtils.mv(path, dest) unless @simulate
  end

  def clean(path, is_dir: false)
    ext = is_dir ? '' : path.realpath.extname
    orig = path.realpath.basename(is_dir ? '' : '.*').to_s
    cleaned = build_cleaned_name(orig)
    cleaned += ext

    [
      orig + ext,
      cleaned,
      (path.realpath.dirname / cleaned).cleanpath
    ]
  end

  def build_cleaned_name(orig)
    cleaned = ActiveSupport::Inflector.transliterate(orig)
    cleaned = cleaned.gsub(/\b\.$|\b\.\b/, ' ')      # dots in middle
                     .gsub(/\[.*?\]/, '')             # bracketed content
                     .gsub(/[^'_\-\p{Alnum}\p{Arabic}]/i, ' ')
                     .gsub(/ \d+p/, '')               # resolution markers like 720p

    remove_words(cleaned, IGNORE_WORDS, '')
    remove_words(cleaned, FRENCH_WORDS, ' FR')

    cleaned = normalize_whitespace(cleaned)

    remove_words(cleaned, SPECIAL_WORDS, '')

    normalize_whitespace(cleaned)
  end

  def remove_words(str, words, replacement)
    words.each do |word|
      str.gsub!(/^#{Regexp.escape(word)}\b|\b#{Regexp.escape(word)}$|\b#{Regexp.escape(word)}\b/i, replacement)
    end
  end

  def normalize_whitespace(str)
    str.squeeze(' ')
       .squeeze('-')
       .strip
       .gsub(/^[-_]+|[-_]+$/, '')
       .strip
  end

  def display(orig, cleaned, dest)
    puts "┌─#{orig.to_s.tr("\r", ' ')}"
    puts "┼─#{cleaned}"
    puts "└─#{dest}"
  end
end

#-- FilenameCleaner --------------------------------------------------------}}}

#-- CLI --------------------------------------------------------------------{{{

PROCESSORS = {
  'cleaner' => FilenameCleaner,
  'useless' => UselessFilesRemover,
  'onefile' => OneFileDirToFileHandler,
  'empty' => EmptyDirRemover
}.freeze

DEFAULT_PROCESSOR_ORDER = %w[cleaner useless onefile empty].freeze

def parse_options
  options = { simulate: true, processors: DEFAULT_PROCESSOR_ORDER.dup }

  parser = OptionParser.new do |opts|
    opts.banner = "Usage: #{File.basename($PROGRAM_NAME)} [options] <directories...>"
    opts.separator ''
    opts.separator 'Cleans filenames, removes useless files, and organizes directories.'
    opts.separator ''
    opts.separator 'Options:'

    opts.on('-f', '--force', 'Execute changes (default is simulation mode)') do
      options[:simulate] = false
    end

    opts.on('--only=PROCESSORS', Array, "Run only specific processors (#{PROCESSORS.keys.join(', ')})") do |list|
      invalid = list - PROCESSORS.keys
      unless invalid.empty?
        warn "Unknown processors: #{invalid.join(', ')}"
        warn "Available: #{PROCESSORS.keys.join(', ')}"
        exit 1
      end
      options[:processors] = list
    end

    opts.on('-h', '--help', 'Show this help message') do
      puts opts
      exit
    end
  end

  parser.parse!
  options
end

def main
  options = parse_options

  if ARGV.empty?
    warn 'Error: No directories specified'
    warn "Usage: #{File.basename($PROGRAM_NAME)} [options] <directories...>"
    exit 1
  end

  options[:processors].each do |name|
    PROCESSORS[name].new(simulate: options[:simulate]).walk_dirs(ARGV)
  end
end

main if __FILE__ == $PROGRAM_NAME

#-- CLI --------------------------------------------------------------------}}}
