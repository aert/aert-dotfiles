# frozen_string_literal: true

require_relative '../support'

# `diff --working`, `--range` and `diff -` (stdin).
class MobileReviewWorkingRangeE2ETest < Minitest::Test
  include MobileReviewHelpers

  def setup
    @repo = build_repo
  end

  def test_e2e_working_includes_untracked_files_respects_gitignore_and_skips_huge_files
    write(@repo, 'README.md', "# edited in the working tree\n")
    write(@repo, 'docs/new.md', "# New doc\n\nBack to [root](../README.md#x) and [guide](guide.md).\n")
    write(@repo, 'newscript', "#!/usr/bin/env python3\nprint(1)\n", mode: 0o755)
    write(@repo, '.gitignore', "ignored.log\n")
    write(@repo, 'ignored.log', 'x')
    write(@repo, 'big.txt', 'a' * 1_200_000)
    write(@repo, 'img.png', PNG)
    r = run_cli('diff', '--working', cwd: @repo)
    assert r.ok?, r.err
    folder = r.path
    patch = page_patch(folder)
    %w[docs/new.md newscript .gitignore img.png].each { |f| assert_includes patch, "b/#{f}", "#{f} is in the diff" }
    # (the text "ignored.log" does appear: it is the content of the untracked .gitignore; look at file headers)
    refute_match(%r{diff --git \S*ignored\.log}, patch)
    refute_match(%r{diff --git \S*big\.txt}, patch)
    html = folder.join('00_diff.html').read
    assert_match(/\(\+4 untracked\)/, html)
    assert_match(/skipped 1 untracked file\(s\) over 1 MB/, html)
    assert_equal %w[00_diff.html README.html new.html], children(folder), 'only changed/new markdown files'
    assert_includes folder.join('README.html').read, 'edited in the working tree', 'working tree version'
    assert_includes folder.join('new.html').read, '<a href="README.html#x">'
    assert_equal 'python', page_config(folder)['langs']['newscript']
    assert_match(/_proj_working\z/, folder.basename.to_s)
  end

  def test_e2e_working_with_only_untracked_files_is_still_a_diff
    write(@repo, 'brand-new.md', "# only untracked\n")
    r = run_cli('diff', '--working', cwd: @repo)
    assert r.ok?, r.err
    assert_equal %w[00_diff.html brand-new.html], children(r.path)
  end

  def test_e2e_working_clean_tree_is_an_error
    r = run_cli('diff', '--working', cwd: @repo)
    refute r.ok?
    assert_match(/nothing to review/, r.err)
  end

  def test_e2e_working_from_a_subdirectory_still_sees_the_whole_repository
    write(@repo, 'docs/sub/deep.md', "# deep\n")
    write(@repo, 'top-level-edit.md', "# top\n")
    r = run_cli('diff', '--working', cwd: @repo.join('docs'))
    assert r.ok?, r.err
    assert_equal %w[00_diff.html deep.html top-level-edit.html], children(r.path)
  end

  def test_e2e_tigs_all_zero_object_id_means_working_changes
    write(@repo, 'README.md', "# edited\n")
    first = run_cli('diff', '--commit', '0' * 40, cwd: @repo)
    assert first.ok?, first.err
    assert_match(/_proj_working\z/, first.path.basename.to_s)
    second = run_cli('diff', '--range', "main...#{'0' * 40}", cwd: @repo)
    assert_match(/_proj_working(-2)?\z/, second.path.basename.to_s) # -2 when sent within the same minute
    refute_equal first.path, second.path
  end

  def test_e2e_range_uses_the_tip_version_of_markdown_and_names_the_folder
    git(@repo, 'switch', '-q', '-c', 'feature')
    write(@repo, 'feat.md', "# Feature doc v1\n")
    git(@repo, 'add', '-A'); git(@repo, 'commit', '-q', '-m', 'f1')
    write(@repo, 'feat.md', "# Feature doc v2 (TIP)\n")
    git(@repo, 'add', '-A'); git(@repo, 'commit', '-q', '-m', 'f2')
    git(@repo, 'switch', '-q', 'main') # feature is NOT checked out
    r = run_cli('diff', '--range', 'main...feature', cwd: @repo)
    assert r.ok?, r.err
    assert_match(/_proj_main-vs-feature\z/, r.path.basename.to_s)
    assert_equal %w[00_diff.html feat.html], children(r.path)
    assert_includes r.path.join('feat.html').read, 'Feature doc v2 (TIP)'
    html = r.path.join('00_diff.html').read
    assert_match(/f2 \(Tester\)/, html)
    assert_match(/f1 \(Tester\)/, html)
  end

  def test_e2e_range_falls_back_to_master_when_there_is_no_main
    repo = build_repo(root: Dir.mktmpdir('mr-master', tmp), branch: 'master')
    git(repo, 'switch', '-q', '-c', 'feature')
    write(repo, 'feat.md', "# f\n")
    git(repo, 'add', '-A'); git(repo, 'commit', '-q', '-m', 'f')
    r = run_cli('diff', '--range', 'main...feature', cwd: repo)
    assert r.ok?, r.err
    assert_equal %w[00_diff.html feat.html], children(r.path)
  end

  def test_e2e_stdin_diff_has_only_the_diff_page_and_needs_no_repository
    patch = "diff --git a/x.md b/x.md\nnew file mode 100644\n--- /dev/null\n+++ b/x.md\n@@ -0,0 +1 @@\n+hello from stdin\n"
    r = run_cli('diff', '-', cwd: tmp, stdin: patch)
    assert r.ok?, r.err
    assert_equal %w[00_diff.html], children(r.path)
    assert_match(/_diff\z/, r.path.basename.to_s)
    assert_includes page_patch(r.path), 'hello from stdin'
  end

  def test_e2e_stdin_with_a_mnemonic_prefix_patch_is_fine
    patch = "diff --git c/x.md w/x.md\n--- c/x.md\n+++ w/x.md\n@@ -1 +1 @@\n-a\n+b\n"
    r = run_cli('diff', '-', cwd: @repo, stdin: patch)
    assert r.ok?, r.err
  end
end
