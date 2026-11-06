# frozen_string_literal: true

require_relative '../support'

# `diff --commit`: the commit under review, its markdown files, the diff page, error cases. Includes the tig regression.
class MobileReviewCommitE2ETest < Minitest::Test
  include MobileReviewHelpers

  def setup
    @repo = build_repo
  end

  def folder_for_head
    r = run_cli('diff', '--commit', 'HEAD', cwd: @repo)
    assert r.ok?, r.err
    r.path
  end

  # THE regression: via tig's `Y` only the first markdown file was converted
  def test_e2e_commit_renders_every_markdown_file_of_the_diff
    folder = folder_for_head
    assert_equal %w[00_diff.html README.html guide.html other__README.html part.html], children(folder)
    assert_match(/\A\d{10}_proj_[0-9a-f]{7,}\z/, folder.basename.to_s)
    no_temp_leftovers!(dest)
  end

  def test_e2e_survives_a_reader_that_closes_stdout_after_the_first_line_like_tig
    cmd = [RbConfig.ruby, SCRIPT, '--dest', dest.to_s, 'diff', '--commit', 'HEAD']
    first = nil
    rest = nil
    IO.popen(cmd, chdir: @repo.to_s, err: %i[child out]) do |io|
      first = io.gets.to_s.chomp
      rest = io.read.to_s # tig reads only one line; anything after it would hit a closed pipe
    end
    assert $?.success?
    assert_equal 0, rest.size, "no output after the first line (converter chatter must not leak): #{rest.inspect}"
    assert Pathname.new(first).directory?, "first line is the folder path: #{first.inspect}"
    assert_equal %w[00_diff.html README.html guide.html other__README.html part.html], children(first)
  end

  def test_e2e_stdout_is_exactly_the_written_path_and_stderr_is_empty
    r = run_cli('diff', '--commit', 'HEAD', cwd: @repo)
    assert_equal 1, r.lines.size
    assert_equal '', r.err
  end

  def test_e2e_markdown_is_the_committed_version_not_the_working_tree
    write(@repo, 'README.md', "# Root WORKING TREE\n")
    write(@repo, 'inc/part.md', "part WORKING TREE\n")
    write(@repo, 'docs/img/a.png', 'not a png')
    folder = folder_for_head
    readme = folder.join('README.html').read
    assert_includes readme, 'Root v2 (COMMITTED)'
    assert_includes readme, 'part v2 (COMMITTED)', 'includes come from the commit too'
    refute_includes readme, 'WORKING TREE'
    assert_includes folder.join('guide.html').read, "data:image/png;base64,#{PNG_B64_PREFIX}", 'images come from the commit'
  end

  def test_e2e_links_between_rendered_markdown_files_point_at_the_siblings
    folder = folder_for_head
    readme = folder.join('README.html').read
    assert_includes readme, '<a href="guide.html#top">'
    assert_includes readme, '<a href="other__README.html">'
    assert_includes folder.join('guide.html').read, '<a href="README.html">'
  end

  def test_e2e_diff_page_links_to_the_rendered_files_and_has_the_language_hints
    cfg = page_config(folder_for_head)
    assert_equal({ 'README.md' => 'README.html', 'docs/guide.md' => 'guide.html', 'inc/part.md' => 'part.html',
                   'other/README.md' => 'other__README.html' }, cfg['rendered'])
    assert_equal 'ruby', cfg['langs']['run']
    refute_includes cfg['rendered'].keys, 'old.md'
  end

  def test_e2e_diff_page_is_self_contained_and_reflects_the_commit
    folder = folder_for_head
    html = folder.join('00_diff.html').read
    refute_match(/(src|href)="https?:\/\//, html)
    refute_match(/@@[A-Z0-9_]+@@/, html, 'every template placeholder is filled')
    assert_includes html, 'font/woff2;base64'
    assert_includes page_patch(folder), 'Root v2 (COMMITTED)'
    assert_match(/<title>[0-9a-f]{7,}  Tester/, html)
  end

  def test_e2e_header_paths_work_with_diff_mnemonic_prefix_in_the_repo_config
    git(@repo, 'config', 'diff.mnemonicPrefix', 'true')
    write(@repo, 'README.md', "# edited\n")
    r = run_cli('diff', '--working', cwd: @repo)
    assert r.ok?, r.err
    assert_includes children(r.path), 'README.html'
  end

  def test_e2e_empty_diff_is_an_error_and_writes_nothing
    git(@repo, 'commit', '-q', '--allow-empty', '-m', 'empty')
    r = run_cli('diff', '--commit', 'HEAD', cwd: @repo)
    refute r.ok?
    assert_match(/nothing to review/, r.err)
    assert_empty dest.children
  end

  def test_e2e_bad_revision_and_bad_selectors_are_errors
    assert_match(/git show failed/, run_cli('diff', '--commit', 'nope', cwd: @repo).err)
    assert_match(/pick exactly one/, run_cli('diff', cwd: @repo).err)
    assert_match(/pick exactly one/, run_cli('diff', '--commit', 'HEAD', '--working', cwd: @repo).err)
    assert_match(/unexpected arguments/, run_cli('diff', 'extra', '--commit', 'HEAD', cwd: @repo).err)
    assert_empty dest.children
  end

  def test_e2e_diff_outside_a_git_repository_fails_cleanly
    r = run_cli('diff', '--commit', 'HEAD', cwd: tmp)
    refute r.ok?
    assert_match(/git rev-parse failed/, r.err)
  end

  def test_e2e_simulate_writes_nothing_and_lists_the_markdown_files
    r = run_cli('-n', 'diff', '--commit', 'HEAD', cwd: @repo)
    assert r.ok?, r.err
    assert_empty dest.children
    assert_match(/4 rendered markdown file\(s\)/, r.out)
    assert_match(/other__README\.html  <-  other\/README\.md  \(at HEAD\)/, r.out)
  end

  def test_e2e_merge_commit_diffs_against_its_first_parent
    git(@repo, 'switch', '-q', '-c', 'side', 'HEAD~1')
    write(@repo, 'side.md', "# side\n")
    git(@repo, 'add', '-A')
    git(@repo, 'commit', '-q', '-m', 'side')
    git(@repo, 'switch', '-q', 'main')
    git(@repo, 'merge', '-q', '--no-ff', '-m', 'merge', 'side')
    r = run_cli('diff', '--commit', 'HEAD', cwd: @repo)
    assert r.ok?, r.err
    assert_equal %w[00_diff.html side.html], children(r.path)
  end
end
