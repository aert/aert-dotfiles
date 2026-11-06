# frozen_string_literal: true

require_relative '../support'

# Reading a diff: header paths (any prefix), markdown files in it, shebang language hints, base branch fallback, common parent.
class MobileReviewDiffParsingTest < Minitest::Test
  include MobileReviewHelpers

  def test_unit_diff_header_regex_accepts_any_one_letter_prefix_and_spaces
    re = MobileReview::DIFF_HEADER_RE
    assert_equal 'dir/file.md', "diff --git a/dir/file.md b/dir/file.md"[re, 1]
    assert_equal 'dir/file.md', "diff --git c/dir/file.md w/dir/file.md"[re, 1] # diff.mnemonicPrefix
    assert_equal 'x.md', "diff --git i/x.md w/x.md"[re, 1]
    assert_equal 'a b.md', "diff --git a/a b.md b/a b.md"[re, 1]
  end

  def test_unit_markdown_files_skips_deleted_and_non_markdown_and_resolves_collisions
    repo = build_repo
    patch = git(repo, 'show', '--format=', '--src-prefix=a/', '--dst-prefix=b/', 'HEAD')
    found = review.send(:markdown_files, patch, repo.to_s, 'HEAD')
    assert_equal({ 'README.md' => 'README', 'docs/guide.md' => 'guide', 'inc/part.md' => 'part', 'other/README.md' => 'other__README' },
                 found.to_h { |m| [m[:path], m[:out]] })
    refute(found.any? { |m| m[:path] == 'old.md' }, 'deleted markdown must be skipped')
  end

  def test_unit_markdown_files_ignores_files_that_do_not_exist_at_the_revision
    repo = build_repo
    patch = "diff --git a/ghost.md b/ghost.md\nnew file mode 100644\n--- /dev/null\n+++ b/ghost.md\n@@ -0,0 +1 @@\n+x\n"
    assert_empty review.send(:markdown_files, patch, repo.to_s, 'HEAD')
  end

  def test_unit_resolve_default_base_falls_back_between_main_and_master
    Dir.chdir(build_repo(branch: 'master')) do
      assert_equal 'master...HEAD', review.send(:resolve_default_base, 'main...HEAD')
      assert_equal 'master...HEAD', review.send(:resolve_default_base, 'master...HEAD')
      assert_equal 'v1...HEAD', review.send(:resolve_default_base, 'v1...HEAD')
    end
    Dir.chdir(build_repo(root: Dir.mktmpdir('mr2', tmp), branch: 'main')) do
      assert_equal 'main...HEAD', review.send(:resolve_default_base, 'master...HEAD')
    end
  end

  def test_unit_shebang_languages_at_a_revision_and_in_the_working_tree
    repo = build_repo
    patch = "diff --git a/run b/run\n--- a/run\n+++ b/run\ndiff --git a/pytool b/pytool\n--- a/pytool\n+++ b/pytool\n" \
            "diff --git a/notes.txt b/notes.txt\n--- a/notes.txt\n+++ b/notes.txt\ndiff --git c/docs/guide.md w/docs/guide.md\n"
    expected = { 'run' => 'ruby', 'pytool' => 'python' } # extension files are left to diff2html
    assert_equal expected, review.send(:shebang_languages, patch, repo.to_s, 'HEAD')
    assert_equal expected, review.send(:shebang_languages, patch, repo.to_s, nil)
    write(repo, 'run', "#!/bin/sh\necho\n")
    assert_equal 'bash', review.send(:shebang_languages, patch, repo.to_s, nil)['run']
    assert_equal 'ruby', review.send(:shebang_languages, patch, repo.to_s, 'HEAD')['run']
  end

  def test_unit_common_parent
    r = review
    assert_equal Pathname.new('/a/b'), r.send(:common_parent, [Pathname.new('/a/b/c.txt'), Pathname.new('/a/b/d/e.txt')])
    assert_equal Pathname.new('/a'), r.send(:common_parent, [Pathname.new('/a/b/c.txt'), Pathname.new('/a/x/y.txt')])
  end
end
