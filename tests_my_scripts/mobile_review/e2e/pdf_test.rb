# frozen_string_literal: true

require_relative '../support'

# PDF output (needs chromium / mmdc; skipped when missing).
class MobileReviewPdfE2ETest < Minitest::Test
  include MobileReviewHelpers

  def test_e2e_diff_folder_in_pdf_mode_has_pdfs_for_the_diff_and_the_markdown_files
    skip 'chromium not installed' unless %w[chromium chromium-browser google-chrome].any? { |c| tool?(c) }
    repo = build_repo
    r = run_cli('--pdf', 'diff', '--commit', 'HEAD', cwd: repo)
    assert r.ok?, r.err
    assert_equal %w[00_diff.pdf README.pdf guide.pdf other__README.pdf part.pdf], children(r.path)
    children(r.path).each { |n| assert (r.path / n).binread.start_with?('%PDF'), n }
  end

  def test_e2e_markdown_to_pdf
    skip 'puppeteer/mmdc not installed' unless tool?('mmdc')
    md = write(tmp, 'a.md', "# A\n").to_s
    r = run_cli('--pdf', md)
    assert r.ok?, r.err
    assert_match(/\A\d{10}_a\.pdf\z/, children(dest).first)
    assert dest.children.first.binread.start_with?('%PDF')
  end
end
