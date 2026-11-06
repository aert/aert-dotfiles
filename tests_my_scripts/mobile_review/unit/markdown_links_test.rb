# frozen_string_literal: true

require_relative '../support'

# Rewriting links between rendered markdown files, and embedding JSON safely in the diff page.
class MobileReviewMarkdownLinksTest < Minitest::Test
  include MobileReviewHelpers

  def test_unit_rewrite_md_links
    map = { 'docs/guide.md' => 'guide.html', 'README.md' => 'README.html', 'other/README.md' => 'other__README.html' }
    html = Pathname.new(tmp).join('x.html')
    cases = {
      'guide.md' => 'guide.html',                 # sibling
      'guide.md#top' => 'guide.html#top',         # fragment kept
      '../README.md' => 'README.html',            # parent
      '/README.md#a' => 'README.html#a',          # GitLab-style root-relative
      '../other/README.md' => 'other__README.html',
      'guide%2Emd' => 'guide.html',               # percent-encoded
      'guide.md?plain=1' => 'guide.html',         # query dropped
      'missing.md' => 'missing.md',               # not part of the folder: unchanged
      'https://example.com/guide.md' => 'https://example.com/guide.md',
      '//cdn.example.com/guide.md' => '//cdn.example.com/guide.md',
      'mailto:a@b.c' => 'mailto:a@b.c',
      '#section' => '#section'
    }
    cases.each do |href, expected|
      html.write(%(<p><a href="#{href}">l</a> <img src="guide.md"></p>))
      review.send(:rewrite_md_links, html, 'docs/x.md', map)
      assert_includes html.read, %(<a href="#{expected}">), "href #{href}"
      assert_includes html.read, '<img src="guide.md">', 'image sources must not be touched'
    end
  end

  def test_unit_json_for_script_cannot_close_the_script_tag
    evil = "x</script><!-- y --><script>alert(1)</script>  "
    json = review.send(:json_for_script, evil)
    refute_includes json, '</script'
    refute_includes json, '<!--'
    assert_equal evil, JSON.parse(json)
  end
end
