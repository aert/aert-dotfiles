# frozen_string_literal: true

require_relative '../support'

# Names and types of the output: classify by extension, YYMMDDHHMM timestamp, collisions, slugs, Syncthing temp names.
class MobileReviewNamingTest < Minitest::Test
  include MobileReviewHelpers

  def test_unit_classify_by_extension
    r = review
    %w[a.md b.MD c.markdown].each { |n| write(tmp, n, 'x'); assert_equal :md, r.classify(File.join(tmp, n)), n }
    %w[a.pdf b.PDF c.png d.JPG e.jpeg f.gif g.webp h.svg i.bmp j.avif k.heic l.heif].each do |n|
      write(tmp, n, 'x')
      assert_equal :copy, r.classify(File.join(tmp, n)), n
    end
    write(tmp, 'x.rb', 'x')
    assert_nil r.classify(File.join(tmp, 'x.rb'))
    assert_nil r.classify(tmp) # a directory
    assert_nil r.classify(File.join(tmp, 'missing.md'))
  end

  def test_unit_timestamp_is_yymmddhhmm
    ts = review.instance_variable_get(:@timestamp)
    assert_match(/\A\d{10}\z/, ts)
    assert_includes [Time.now.strftime('%y%m%d%H%M'), (Time.now - 60).strftime('%y%m%d%H%M')], ts
  end

  def test_unit_target_path_collisions_for_files_and_folders
    r = review
    ts = r.instance_variable_get(:@timestamp)
    assert_equal dest / "#{ts}_notes.html", r.send(:target_path, 'notes', 'html')
    FileUtils.touch(dest / "#{ts}_notes.html")
    assert_equal dest / "#{ts}_notes-2.html", r.send(:target_path, 'notes', 'html')
    FileUtils.touch(dest / "#{ts}_notes-2.html")
    assert_equal dest / "#{ts}_notes-3.html", r.send(:target_path, 'notes', 'html')
    (dest / "#{ts}_dir").mkpath
    assert_equal dest / "#{ts}_dir-2", r.send(:target_path, 'dir', nil)
  end

  def test_unit_slug_keeps_safe_characters_only
    r = review
    assert_equal 'my_file_+1.v2', r.send(:slug, 'my file +1.v2')
    assert_equal 'a_b', r.send(:slug, 'a/b')
    assert_equal 'x', r.send(:slug, '__x__')
  end

  def test_unit_syncthing_temp_name
    assert_equal Pathname.new('/d/.syncthing.2611061219_a.html.tmp'), review.send(:syncthing_temp, Pathname.new('/d/2611061219_a.html'))
  end
end
