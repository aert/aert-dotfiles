# frozen_string_literal: true

# Generic helpers shared by the tests of every script in my_scripts/ (nothing script-specific here).
# Per-script helpers live in tests_my_scripts/<script>/support.rb and build on this.

require 'minitest/autorun'
require 'fileutils'
require 'json'
require 'open3'
require 'pathname'
require 'rbconfig'
require 'stringio'
require 'tmpdir'

module TestSupport
  # Scratch directory, removed after each test.
  def tmp
    @tmp ||= Dir.mktmpdir('my-scripts-test')
  end

  def teardown
    FileUtils.remove_entry(@tmp) if @tmp
    super
  end

  # Scratch output directory (stand-in for e.g. the Syncthing folder).
  def dest
    @dest ||= Pathname.new(tmp).join('dest').tap(&:mkpath)
  end

  def write(root, rel, content, mode: nil)
    path = Pathname.new(root).join(rel)
    path.dirname.mkpath
    path.binwrite(content)
    path.chmod(mode) if mode
    path
  end

  def git(repo, *args)
    out, err, status = Open3.capture3('git', '-C', repo.to_s, *args)
    raise "git #{args.join(' ')} failed: #{err}" unless status.success?

    out
  end

  # Names of the entries of a directory, sorted.
  def children(dir) = Pathname.new(dir).children.map { |c| c.basename.to_s }.sort

  def tool?(name) = system("command -v #{name} > /dev/null 2>&1")
end
