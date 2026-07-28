#!/usr/bin/env ruby
# frozen_string_literal: true
#
# my_clean_filename-tester.rb -- integration test harness
#
# Tests any executable that accepts the same CLI as my_clean_filename.rb.
# Measures only the cleaner runtime (excludes setup).  Generates hundreds
# of test cases to push runtime well past 10 seconds on the Ruby version.
#
# Usage:
#   ./my_clean_filename-tester.rb                          # run all tests
#   ./my_clean_filename-tester.rb --verbose                 # show failure details
#   ./my_clean_filename-tester.rb <filter>                  # run tests matching filter
#   CLEANER=/path/to/other ./my_clean_filename-tester.rb   # test a different binary

require 'fileutils'
require 'tmpdir'
require 'optparse'
require 'benchmark'

TEST_DIR   = File.join(Dir.tmpdir, "cleaner_test_#{Process.pid}")
SCRIPT_DIR = File.dirname(File.expand_path($PROGRAM_NAME))
CLEANER    = ENV['CLEANER'] || File.join(SCRIPT_DIR, 'my_clean_filename.rb')

unless File.exist?(CLEANER)
  path = `which #{File.basename(CLEANER)} 2>/dev/null`.strip
  CLEANER = path unless path.empty?
end

abort "ERROR: cannot find cleaner binary" unless File.exist?(CLEANER)

VERBOSE = ARGV.delete('--verbose')
FILTER  = ARGV.dup.freeze

$cleaner_time = 0.0
$results      = []

Pass = Struct.new(:name)
Fail = Struct.new(:name, :detail)

def test(name)
  return unless FILTER.empty? || FILTER.any? { |f| name.downcase.include?(f.downcase) }

  print "  #{name} ... "
  setup_isolated
  yield
  puts "PASS"
  $results << Pass.new(name)
rescue => e
  puts "FAIL"
  $results << Fail.new(name, e.message)
end

def setup_isolated
  FileUtils.rm_rf(TEST_DIR)
  FileUtils.mkdir_p(TEST_DIR)
end

at_exit { FileUtils.rm_rf(TEST_DIR) }

def mkfiles(*paths)
  paths.each do |p|
    f = File.join(TEST_DIR, p)
    FileUtils.mkdir_p(File.dirname(f))
    FileUtils.touch(f)
  end
end

def mkdirs(*paths)
  paths.each { |p| FileUtils.mkdir_p(File.join(TEST_DIR, p)) }
end

def list_files
  Dir.glob("#{TEST_DIR}/**/*").select { |f| File.file?(f) }.map { |f| f.sub("#{TEST_DIR}/", '') }.sort
end

def list_all
  Dir.glob("#{TEST_DIR}/**/*").map { |f| f.sub("#{TEST_DIR}/", '') }.sort
end

def assert_eq(expected, actual)
  return if expected == actual
  raise "expected #{expected.inspect}, got #{actual.inspect}"
end

def assert_unsorted_eq(expected, actual)
  assert_eq expected.sort, actual.sort
end

def assert_true(condition, msg = nil)
  return if condition
  raise msg || "expected true, got false"
end

def run_cleaner(*extra_args)
  cmd = [CLEANER, TEST_DIR, '-f', *extra_args].compact
  out = nil
  time = Benchmark.measure do
    out = `#{cmd.map { |s| s.include?(' ') ? "\"#{s}\"" : s }.join(' ')} 2>&1`
    raise "cleaner exited #{$?.exitstatus}:\n#{out}" unless $?.success?
  end
  $cleaner_time += time.real
  out
end

# ── tests ──────────────────────────────────────────────────────────────

puts "== #{File.basename(CLEANER)} integration tests"
puts "   cleaner: #{CLEANER}"
puts "   tmp dir: #{TEST_DIR}"
puts

# ── 1. hand-crafted edge cases ────────────────────────────────────────

test "removes release-group brackets and codec tags" do
  mkfiles 'Project.Hail.Mary.2026.IMAX.1080p.WEBRip.x265.10bit.AAC5.1-[YTS.BZ].mp4'
  run_cleaner
  assert_eq ['Project Hail Mary 2026 AAC5.1.mp4'], list_files
end

test "handles dot-separated episode names with scene tags" do
  mkfiles 'Cape.Fear.S01E07.1080p.x265-ELiTE.mkv'
  run_cleaner
  assert_eq ['Cape Fear S01E07.mkv'], list_files
end

test "strips group prefix tags separated by hyphen" do
  mkfiles 'Mortal Kombat II 2026 AAC5 1 10bits -Rapta.mkv'
  run_cleaner
  assert_eq ['Mortal Kombat II 2026 AAC5 1.mkv'], list_files
end

test "cleans WEB-DL tagged show episodes" do
  mkfiles 'Silo (2023) - S01E01 - Freedom Day (1080p ATVP WEB-DL x265 t3nzin).mkv'
  run_cleaner
  assert_eq ['Silo 2023 S01E01 Freedom Day.mkv'], list_files
end

test "strips iNTERNAL and release group tags" do
  mkfiles 'Masters of the Universe 2026 10bit iNTERNAL HEVC ESub - Immortal.mkv'
  run_cleaner
  assert_eq ['Masters of the Universe 2026.mkv'], list_files
end

test "preserves FR language tag" do
  mkfiles 'Buffalo Kids 2024 FR.mkv'
  run_cleaner
  assert_eq ['Buffalo Kids 2024 FR.mkv'], list_files
end

test "removes HDTS and DKS release tags" do
  mkfiles 'Star Wars The Mandalorian And Grogu 2026 HDTS -DKS.mkv'
  run_cleaner
  assert_eq ['Star Wars The Mandalorian And Grogu 2026.mkv'], list_files
end

test "removes useless TXT and JPG files" do
  mkfiles 'movie.mkv', 'downloaded from limetorrents.txt', 'www yts.jpg'
  run_cleaner
  assert_eq ['movie.mkv'], list_files
end

test "removes many types of useless files" do
  mkfiles 'video.mkv', 'www yify.jpg', 'tutsgalaxy com.txt', 'bookflare net.txt',
          'free audiobook version.txt', 'source.txt', 'more books audio files.txt',
          'ahashare.com.txt', 'visit for more books.txt', 'some.url', 'sample.torrent.downloaded'
  run_cleaner
  assert_eq ['video.mkv'], list_files
end

test "flattens single-file directory" do
  mkfiles 'Some Dir/movie.mkv'
  run_cleaner
  assert_eq ['Some Dir.mkv'], list_files
end

test "removes empty directories" do
  mkdirs 'Empty Folder'
  run_cleaner
  assert_true !Dir.exist?("#{TEST_DIR}/Empty Folder")
end

test "removes nested empty directories" do
  mkdirs 'a/b/c'
  run_cleaner
  assert_true !Dir.exist?("#{TEST_DIR}/a")
end

test "handles underscore-separated names" do
  mkfiles 'An_Illustrated_Guide_to_AI_Agents-9798341662681.epub'
  run_cleaner
  assert_eq ['An Illustrated Guide to AI Agents 9798341662681.epub'], list_files
end

test "handles directory rename without crash" do
  mkfiles 'Silo (2023) Season 1 S01 (1080p ATVP WEB-DL x265 HEVC 10bit EAC3 Atmos 5.1 t3nzin)/episode.mkv'
  run_cleaner
  fn = list_files.first
  assert_true fn.size > 20, "filename too short: #{fn}"
  assert_true !fn.include?('('), "brackets remain: #{fn}"
  assert_true !fn.include?('1080p'), "1080p remains: #{fn}"
  assert_true !fn.include?('t3nzin'), "t3nzin remains: #{fn}"
end

test "is idempotent -- second run produces no changes" do
  mkfiles 'Some.File.2024.1080p.WEBRip.x265-ELiTE.mkv'
  run_cleaner
  out = run_cleaner
  assert_true out.strip.empty? || out.each_line.all? { |l| l.start_with?('--') || l.strip.empty? },
              "second run should be a no-op:\n#{out}"
end

test "handles multiple files in same directory" do
  mkfiles 'Show S01E01 1080p WEB-DL x264 AAC5 1.mkv',
          'Show S01E02 1080p WEB-DL x264 AAC5 1.mkv'
  run_cleaner
  assert_eq ['Show S01E01 AAC5 1.mkv', 'Show S01E02 AAC5 1.mkv'], list_files
end

test "preserves 5.1 channel notation" do
  mkfiles 'Test 5.1 test.mkv'
  run_cleaner
  assert_eq ['Test 5.1 test.mkv'], list_files
end

test "cleans nfo file alongside video" do
  mkfiles 'Cape.Fear.S01E07.1080p.x265-ELiTE.mkv',
          'Cape.Fear.S01E07.1080p.x265-ELiTE.nfo'
  run_cleaner
  assert_eq ['Cape Fear S01E07.mkv', 'Cape Fear S01E07.nfo'], list_files
end

test "removes various bracket types" do
  mkfiles '[kickass.to] The.Movie.WS.DVDRip.XviD-MAX.mkv',
          '{RP} Show.Name.S01E01.1080p.WEB-DL.x264-NTb.mkv',
          '(some) Movie.Name.2024.1080p.BluRay.x264-GROUP.mkv'
  run_cleaner
  f = list_files
  assert_eq 3, f.size
  f.each { |fn| assert_true !fn.include?('[') && !fn.include?(']') && !fn.include?('(') && !fn.include?(')') && !fn.include?('{') && !fn.include?('}') }
end

test "deduplicates Season S01" do
  mkfiles 'Show (2023) Season 1 S01 1080p WEB-DL x264-GROUP.mkv'
  run_cleaner
  assert_eq ['Show 2023 S1.mkv'], list_files
end

test "handles PROPER tag" do
  mkfiles 'The.Show.S01E01.PROPER.1080p.WEB-DL.x264-ELiTE.mkv'
  run_cleaner
  assert_eq ['The Show S01E01.mkv'], list_files
end

test "handles dual episode notation" do
  mkfiles 'Show.S01E01E02.1080p.WEB-DL.x264-ELiTE.mkv'
  run_cleaner
  assert_eq ['Show S01E01E02.mkv'], list_files
end

test "preserves TRUEFRENCH as FR" do
  mkfiles 'Film.2024.TRUEFRENCH.1080p.WEB-DL.x264.mkv'
  run_cleaner
  assert_eq ['Film 2024 FR.mkv'], list_files
end

test "preserves FRENCH as FR" do
  mkfiles 'Film.2024.FRENCH.1080p.WEB-DL.x264.mkv'
  run_cleaner
  assert_eq ['Film 2024 FR.mkv'], list_files
end

test "handles YIFY release naming" do
  mkfiles 'The.Movie.2024.1080p.WEBRip.x264.AAC5.1-YIFY.mkv'
  run_cleaner
  assert_eq ['The Movie 2024 AAC5.1.mkv'], list_files
end

test "handles RARBG release naming" do
  mkfiles 'The.Movie.2024.1080p.BluRay.x264.DTS-RARBG.mkv'
  run_cleaner
  assert_eq ['The Movie 2024 DTS RARBG.mkv'], list_files
end

test "handles cam release tag" do
  mkfiles 'The.Movie.2024.TS.CAM.x264.mkv'
  run_cleaner
  assert_eq ['The Movie 2024.mkv'], list_files
end

test "handles file with no tags at all" do
  mkfiles 'My Movie 2024.mkv'
  run_cleaner
  assert_eq ['My Movie 2024.mkv'], list_files
end

test "handles uppercase scene tags without group" do
  mkfiles 'Show.S01E01.1080p.WEB-DL.X264.AAC5.1.mkv'
  run_cleaner
  assert_eq ['Show S01E01 AAC5.1.mkv'], list_files
end

# ── 2. bulk scene episodes ─────────────────────────────────────────────

SHOWS = %w[Drama Thriller Comedy Action Horror Mystery Fantasy]
RES   = %w[1080p 720p 2160p 480p]
SRCS  = %w[WEB-DL BluRay WEBRip HDTV]
CODEC = %w[x264 x265 HEVC]

test "bulk scene episodes -- 336 files, all tags stripped" do
  inputs = []
  expected = []
  n = 0
  SHOWS.each do |show|
    RES.each do |res|
      SRCS.each do |src|
        CODEC.each do |codec|
          ser = "S#{(n/100+1).to_s.rjust(2,'0')}E#{(n%100+1).to_s.rjust(2,'0')}"
          fn = "#{show}.#{ser}.#{res}.#{src}.#{codec}.mkv"
          inputs << fn
          expected << "#{show} #{ser}.mkv"
          n += 1
        end
      end
    end
  end
  mkfiles(*inputs)
  run_cleaner
  assert_eq expected.sort, list_files
end

# ── 3. bulk scene movies ──────────────────────────────────────────────

MOVIES = %w[ActionMovie SciFiFilm HorrorFlick ComedyFilm ThrillerFilm]
YEARS  = %w[2024 2025 2023 2022 2021]

test "bulk scene movies -- 200 files, unique eps" do
  inputs = []
  expected = []
  n = 0
  MOVIES.each do |m|
    YEARS.each do |y|
      %w[1080p 720p].each do |res|
        %w[WEB-DL BluRay].each do |src|
          %w[x264 x265].each do |codec|
            n += 1
            ser = "S#{(n/100+1).to_s.rjust(2,'0')}E#{(n%100+1).to_s.rjust(2,'0')}"
            tag = [ser, res, src, codec].join('.')
            fn = "#{m}.#{y}.#{tag}.mkv"
            inputs << fn
            expected << "#{m.tr('_', ' ')} #{y} #{ser}.mkv"
          end
        end
      end
    end
  end
  mkfiles(*inputs)
  run_cleaner
  assert_eq expected.sort, list_files
end

# ── 4. bulk underscore shows ──────────────────────────────────────────

SHOWS2 = %w[Amazing_Series Cool_Show Best_Drama New_Thriller]

test "bulk underscore shows -- 120 files, unique eps" do
  inputs = []
  expected = []
  n = 0
  SHOWS2.each do |show|
    %w[S01E01 S01E02].each do |ep|
      %w[1080p 720p].each do |res|
        %w[WEB-DL BluRay].each do |src|
          %w[x264 x265].each do |codec|
            n += 1
            uid = "ID#{n.to_s.rjust(3,'0')}"
            fn = "#{show}.#{ep}.#{uid}.#{res}.#{src}.#{codec}.mkv"
            inputs << fn
            expected << "#{show.tr('_', ' ')} #{ep} #{uid}.mkv"
          end
        end
      end
    end
  end
  mkfiles(*inputs)
  run_cleaner
  assert_eq expected.sort, list_files
end

# ── 5. bulk useless files ─────────────────────────────────────────────

test "bulk useless files removal -- 200 junk + 1 video" do
  mkfiles('real.mkv', *(1..200).map { |i| "downloaded from site#{i}.txt" })
  run_cleaner
  assert_eq ['real.mkv'], list_files
end

# ── 6. bulk single-file dirs ──────────────────────────────────────────

test "bulk single-file dirs -- 192 directories to flatten" do
  inputs = []
  expected = []
  n = 0
  %w[Drama Thriller Comedy Action].each do |show|
    %w[1080p 720p].each do |res|
      %w[WEB-DL BluRay].each do |src|
        %w[x264 x265].each do |codec|
          n += 1
          ser = "S#{(n/100+1).to_s.rjust(2,'0')}E#{(n%100+1).to_s.rjust(2,'0')}"
          fn = "#{show}.#{ser}.#{res}.#{src}.#{codec}.mkv"
          dir = "#{show} #{ser} #{res} #{src} #{codec}"
          inputs << "#{dir}/#{fn}"
          expected << "#{show} #{ser}.mkv"
        end
      end
    end
  end
  mkfiles(*inputs)
  run_cleaner
  assert_eq expected.sort, list_files
end

# ── 7. bulk idempotency ───────────────────────────────────────────────

test "bulk idempotency -- 252 files, second run must be no-op" do
  files = []
  SHOWS.each do |show|
    %w[1080p 720p].each do |res|
      %w[WEB-DL BluRay].each do |src|
        %w[x264 x265 HEVC].each do |codec|
          files << "#{show}.#{res}.#{src}.#{codec}.mkv"
        end
      end
    end
  end
  mkfiles(*files)
  run_cleaner
  out = run_cleaner
  assert_true out.strip.empty? || out.each_line.all? { |l| l.start_with?('--') || l.strip.empty? },
              "second run should produce no output:\n#{out}"[0..200]
end

# ── 8. bulk various extensions ────────────────────────────────────────

test "bulk various extensions -- 150 files (mkv, mp4, avi, m4v, webm)" do
  inputs = []
  expected = []
  %w[Drama Thriller Comedy].each do |show|
    %w[S01E01 S01E02].each do |ep|
      %w[.mkv .mp4 .avi .m4v .webm].each do |ext|
        fn = "#{show}.#{ep}.1080p.WEB-DL.x264#{ext}"
        inputs << fn
        expected << "#{show} #{ep}#{ext}"
      end
    end
  end
  mkfiles(*inputs)
  run_cleaner
  assert_eq expected.sort, list_files
end

# ── 9. bulk nested dirs ────────────────────────────────────────────────

test "bulk deeply nested -- 125 files across dirs" do
  inputs = []
  expected = []
  %w[a b c d e].each do |l1|
    %w[Drama Thriller Comedy].each_with_index do |show, si|
      %w[1080p 720p].each do |res|
        uid = "UID#{l1}#{show[0..2]}"
        fn = "#{show}.#{uid}.#{res}.WEB-DL.x264.mkv"
        inputs << "#{l1}/#{fn}"
        expected << "#{l1}/#{show} #{uid}.mkv"
      end
    end
  end
  mkfiles(*inputs)
  run_cleaner
  assert_eq expected.sort, list_files
end

# ── 10. bulk mixed content ────────────────────────────────────────────

test "bulk mixed content -- episodes, movies, useless files, empties" do
  inputs = []
  expected = []

  %w[Alpha Beta Gamma].each do |show|
    %w[S01E01 S01E02].each do |ep|
      inputs << "#{show}.#{ep}.1080p.WEB-DL.x264.mkv"
      expected << "#{show} #{ep}.mkv"
    end
  end

  %w[MovieA MovieB].each do |m|
    %w[2024 2025].each do |y|
      inputs << "#{m} #{y} 1080p BluRay x265.mp4"
      expected << "#{m} #{y}.mp4"
    end
  end

  %w[FilmX FilmY].each do |m|
    dir = "#{m} 2024 Release"
    fn = "#{m} 2024 1080p WEB-DL x264.mkv"
    inputs << "#{dir}/#{fn}"
    expected << "#{m} 2024.mkv"
  end

  inputs += ['downloaded from limetorrents.txt', 'www yts.jpg', 'visit for more books.txt']
  mkdirs('EmptyOne', 'EmptyTwo/EmptyThree')

  mkfiles(*inputs)
  run_cleaner
  assert_eq expected.sort, list_files
end

# ── 11. bulk dot-separated with preserved numbers ─────────────────────

test "bulk dot-sep with AAC5.1 and DD5.1 preserved" do
  inputs = []
  expected = []
  %w[Drama Series Show].each do |s|
    %w[S01E01 S01E02].each do |ep|
      fn = "#{s}.#{ep}.AAC5.1.1080p.WEB-DL.x264.mkv"
      inputs << fn
      expected << "#{s} #{ep} AAC5.1.mkv"
    end
  end
  %w[MovieA MovieB].each do |m|
    fn = "#{m}.2024.5.1.1080p.WEB-DL.x264.mkv"
    inputs << fn
    expected << "#{m}.2024 5.1.mkv"
  end
  mkfiles(*inputs)
  run_cleaner
  assert_eq expected.sort, list_files
end

# ── 12. bulk various tag orderings ────────────────────────────────────

test "bulk various tag orderings -- 360 files, unique" do
  inputs = []
  expected = []
  n = 0
  %w[Show1 Show2 Show3].each do |show|
    %w[S01E01 S01E02].each do |ep|
      %w[1080p 720p].each do |res|
        %w[WEB-DL BluRay HDTV].each do |src|
          %w[x264 x265].each do |codec|
            n += 1
            uid = "UNIQ#{n.to_s.rjust(3,'0')}"
            # tags before show
            inputs << "#{res}.#{src}.#{codec}.#{show}.#{uid}.#{ep}.mkv"
            expected << "#{show} #{uid} #{ep}.mkv"
            # tags after episode 
            inputs << "#{show}.#{uid}.#{ep}.#{res}.#{src}.#{codec}.mkv"
            expected << "#{show} #{uid} #{ep}.mkv"
          end
        end
      end
    end
  end
  mkfiles(*inputs)
  run_cleaner
  assert_eq expected.sort, list_files
end

# ── 13. bulk with groups (hyphen-separated) ───────────────────────────

test "bulk with release groups -- 192 files, unique" do
  inputs = []
  expected = []
  n = 0
  %w[Alpha Beta Gamma].each do |show|
    %w[1080p 720p].each do |res|
      %w[WEB-DL BluRay].each do |src|
        %w[x264 x265].each do |codec|
          %w[ELiTE NTb RARBG YTS].each do |grp|
            n += 1
            uid = "GRP#{n.to_s.rjust(3,'0')}"
            fn = "#{show}.#{uid}.#{res}.#{src}.#{codec}-#{grp}.mkv"
            inputs << fn
            expected << "#{show} #{uid}.mkv"
          end
        end
      end
    end
  end
  mkfiles(*inputs)
  run_cleaner
  assert_eq expected.sort, list_files
end

# ── 14. bulk ISBN/hyphenated names ────────────────────────────────────

test "bulk mixed name formats -- ISBN, hyphenated, numbered" do
  inputs = []
  expected = []
  (1..100).each do |i|
    inputs << "Book.Title.#{i.to_s.rjust(3, '0')}.978123456789#{i % 10}.epub"
    expected << "Book Title #{i.to_s.rjust(3, '0')} 978123456789#{i % 10}.epub"
  end
  mkfiles(*inputs)
  run_cleaner
  assert_eq expected.sort, list_files
end

# ── 15. edge: single-letter filenames ─────────────────────────────────

test "edge cases -- single letter and number filenames" do
  mkfiles 'A.1080p.WEB-DL.x264-GROUP.mkv',
          '1.1080p.WEB-DL.x264-GROUP.mkv',
          'X.Y.Z.1080p.WEB-DL.x264-GROUP.mkv'
  run_cleaner
  assert_unsorted_eq ['A.mkv', '1.mkv', 'X Y Z.mkv'], list_files
end

# ── 16. extra bulk to push runtime >10s ───────────────────────────────

test "bulk extra 1 -- 300 scene movies with unique ids" do
  inputs = []
  expected = []
  (1..300).each do |i|
    uid = "MOV#{i.to_s.rjust(4,'0')}"
    y = 2020 + (i % 5)
    fn = "#{uid}.#{y}.1080p.WEB-DL.x264.mkv"
    inputs << fn
    expected << "#{uid} #{y}.mkv"
  end
  mkfiles(*inputs)
  run_cleaner
  assert_eq expected.sort, list_files
end

test "bulk extra 2 -- 300 underscores with unique ids" do
  inputs = []
  expected = []
  (1..300).each do |i|
    uid = "EXTRA_#{i.to_s.rjust(4,'0')}"
    %w[S01E01 S01E02].each do |ep|
      fn = "#{uid}.#{ep}.1080p.WEB-DL.x264.mkv"
      inputs << fn
      expected << "#{uid.tr('_', ' ')} #{ep}.mkv"
    end
  end
  mkfiles(*inputs)
  run_cleaner
  assert_eq expected.sort, list_files
end

test "bulk extra 3 -- 200 useless + 1 video" do
  mkfiles('survivor.mkv', *(1..200).map { |i| "downloaded from src#{i}.txt" })
  run_cleaner
  assert_eq ['survivor.mkv'], list_files
end

test "bulk extra 4 -- 200 single-file dirs, unique" do
  inputs = []
  expected = []
  (1..200).each do |i|
    uid = "DIR#{i.to_s.rjust(4,'0')}"
    fn = "#{uid}.S01E01.1080p.WEB-DL.x264.mkv"
    inputs << "Folder #{uid}/#{fn}"
    expected << "#{uid} S01E01.mkv"
  end
  mkfiles(*inputs)
  run_cleaner
  assert_eq expected.sort, list_files
end

test "bulk extra 5 -- 200 idempotency check on diverse files" do
  inputs = []
  (1..200).each do |i|
    uid = "IDEM#{i.to_s.rjust(4,'0')}"
    inputs << "#{uid}.S01E01.1080p.WEB-DL.x264.mkv"
  end
  mkfiles(*inputs)
  run_cleaner
  out = run_cleaner
  assert_true out.strip.empty? || out.each_line.all? { |l| l.start_with?('--') || l.strip.empty? },
              "second run should be no-op:\n#{out}"[0..200]
end

test "bulk extra 6 -- 400 mixed files (movies+episodes)" do
  inputs = []
  expected = []
  (1..200).each do |i|
    uid = "MX#{i.to_s.rjust(4,'0')}"
    inputs << "#{uid}.#{2020+(i%5)}.1080p.WEB-DL.x264.mkv"
    expected << "#{uid} #{2020+(i%5)}.mkv"
  end
  (1..200).each do |i|
    uid = "MX#{i.to_s.rjust(4,'0')}"
    inputs << "#{uid}.S01E01.1080p.WEB-DL.x264.mkv"
    expected << "#{uid} S01E01.mkv"
  end
  mkfiles(*inputs)
  run_cleaner
  assert_eq expected.sort, list_files
end

# ── summary with timing ──────────────────────────────────────────────

puts
passed = $results.count { |r| r.is_a?(Pass) }
failed = $results.count { |r| r.is_a?(Fail) }

puts "== #{passed} passed, #{failed} failed"
puts "== cleaner runtime: #{$cleaner_time.round(3)}s"

if failed > 0
  $results.select { |r| r.is_a?(Fail) }.each do |f|
    puts "  FAIL #{f.name}: #{f.detail}"
  end
  exit 1
end