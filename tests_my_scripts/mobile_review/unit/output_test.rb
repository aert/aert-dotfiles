# frozen_string_literal: true

require_relative '../support'

# What the script prints: converter output is captured (tig keeps only the first stdout line), closed pipes are fine.
class MobileReviewOutputTest < Minitest::Test
  include MobileReviewHelpers

  def test_unit_capture_output_swallows_stdout_and_stderr_and_restores_them
    r = review
    before = [$stdout, $stderr]
    log = r.send(:capture_output) { puts 'progress'; warn 'noise' }
    assert_equal "progress\nnoise\n", log
    assert_equal before, [$stdout, $stderr]
    assert_raises(RuntimeError) { r.send(:capture_output) { raise 'boom' } }
    assert_equal before, [$stdout, $stderr], 'streams are restored even when the block raises'
  end

  def test_unit_say_path_ignores_a_closed_pipe
    broken = Class.new do # a stdout whose reader has gone away
      def write(*) = raise(Errno::EPIPE)
      def puts(*) = raise(Errno::EPIPE)
      def flush = nil
    end.new
    saved = $stdout
    $stdout = broken
    review.send(:say_path, Pathname.new('/x')) # must not raise
  ensure
    $stdout = saved
  end

  def test_unit_log_tail
    r = review
    assert_equal '', r.send(:log_tail, '')
    assert_equal ' (last line)', r.send(:log_tail, "first\nlast line\n\n")
  end
end
