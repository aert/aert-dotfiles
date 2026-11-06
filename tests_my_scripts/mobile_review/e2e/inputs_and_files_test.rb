# frozen_string_literal: true

require_relative '../support'

# Implicit mode (md / pdf / images), `md`, `files`, destination handling, dry runs.
class MobileReviewFilesE2ETest < Minitest::Test
  include MobileReviewHelpers

  def sample_md(name, body = "# #{name}\n\n![px](px.png)\n")
    write(tmp, "src/#{name}", body)
    write(tmp, 'src/px.png', PNG)
    File.join(tmp, 'src', name)
  end

  def test_e2e_implicit_mode_converts_several_markdown_files_at_once
    a = sample_md('a.md')
    b = sample_md('b.markdown', "# B\n")
    r = run_cli(a, b)
    assert r.ok?, r.err
    assert_equal 2, r.lines.size, 'one stdout line (the path) per output'
    assert_equal '', r.err
    names = children(dest)
    assert_equal 2, names.size
    assert(names.all? { |n| n.match?(/\A\d{10}_[ab]\.html\z/) }, names.inspect)
    assert_includes (dest / names.find { |n| n.end_with?('_a.html') }).read, "data:image/png;base64,#{PNG_B64_PREFIX}"
    no_temp_leftovers!(dest)
  end

  def test_e2e_explicit_md_subcommand_still_works_and_name_overrides
    r = run_cli('--name', 'renamed', 'md', sample_md('a.md'))
    assert r.ok?, r.err
    assert_match(/\A\d{10}_renamed\.html\z/, children(dest).first)
  end

  def test_e2e_pdf_and_images_are_copied_byte_for_byte_with_a_lowercase_extension
    pdf = write(tmp, 'src/report.pdf', "%PDF-1.4 fake\n\x00\xFF binary")
    png = write(tmp, 'src/Shot.PNG', PNG)
    r = run_cli(pdf.to_s, png.to_s)
    assert r.ok?, r.err
    out = children(dest)
    assert_equal 2, out.size
    assert_equal pdf.binread, (dest / out.grep(/report\.pdf\z/).first).binread
    shot = out.grep(/Shot\.png\z/)
    assert_equal 1, shot.size, out.inspect
    assert_equal png.binread, (dest / shot.first).binread
  end

  def test_e2e_mixed_inputs_each_produce_their_own_output
    r = run_cli(sample_md('a.md'), write(tmp, 'src/p.pdf', '%PDF').to_s, write(tmp, 'src/i.webp', 'x').to_s)
    assert r.ok?, r.err
    assert_equal %w[a.html i.webp p.pdf], children(dest).map { |n| n.sub(/\A\d{10}_/, '') }
  end

  def test_e2e_unknown_missing_and_ambiguous_inputs_fail_before_writing_anything
    ok = sample_md('a.md')
    rb = write(tmp, 'src/x.rb', 'x').to_s
    r = run_cli(ok, rb)
    refute r.ok?
    assert_match(/don't know what to do with: .*x\.rb.*files PATH/, r.err)
    assert_match(/no such file/, run_cli(ok, File.join(tmp, 'nope.png')).err)
    assert_match(/only makes sense with a single input/, run_cli('--name', 'x', ok, ok).err)
    assert_match(/don't know what to do/, run_cli(File.join(tmp, 'src')).err, 'directories need `files`')
    assert_empty dest.children, 'nothing may be written when any argument is rejected'
  end

  def test_e2e_same_name_twice_in_the_same_minute_gets_a_numeric_suffix
    a = sample_md('a.md')
    run_cli(a); run_cli(a)
    names = children(dest)
    assert_equal 2, names.size
    assert_equal names.size, names.uniq.size
    assert(names.all? { |n| n.match?(/\A\d{10}_a(-2)?\.html\z/) }, names.inspect)
  end

  def test_e2e_no_arguments_prints_usage_and_fails
    r = run_cli
    refute r.ok?
    assert_match(/Usage:/, r.err)
  end

  def test_e2e_missing_destination_is_refused_before_any_work_and_never_created
    gone = Pathname.new(tmp).join('not-there')
    r = run_cli(sample_md('a.md'), dest_dir: gone)
    refute r.ok?
    assert_match(/does not exist/, r.err)
    refute gone.exist?
  end

  def test_e2e_simulate_writes_nothing_for_every_input_kind
    a = sample_md('a.md')
    p = write(tmp, 'src/p.pdf', '%PDF').to_s
    r = run_cli('-n', a, p)
    assert r.ok?, r.err
    assert_match(/would write/, r.out)
    assert_empty dest.children
    assert run_cli('-n', 'files', File.join(tmp, 'src')).ok?
    assert_empty dest.children
  end

  def test_e2e_files_copies_into_a_folder_relative_to_the_common_parent_skipping_git
    write(tmp, 'proj/src/a.txt', 'a')
    write(tmp, 'proj/src/sub/b.txt', 'b')
    write(tmp, 'proj/src/.git/config', 'git-internal')
    write(tmp, 'proj/notes.md', 'n')
    File.symlink('notes.md', File.join(tmp, 'proj/link.md'))
    r = run_cli('files', File.join(tmp, 'proj/src'), File.join(tmp, 'proj/notes.md'), File.join(tmp, 'proj/link.md'))
    assert r.ok?, r.err
    folder = r.path
    assert_match(/\A\d{10}_src_\+2\z/, folder.basename.to_s)
    assert_equal %w[link.md notes.md src], children(folder)
    assert_equal %w[a.txt sub], children(folder / 'src')
    refute (folder / 'src/.git').exist?
    refute (folder / 'link.md').symlink?, 'symlinks are stored as regular files'
    assert_equal 'n', (folder / 'link.md').read
    no_temp_leftovers!(dest)
  end

  def test_e2e_files_errors
    assert_match(/no such file or directory/, run_cli('files', File.join(tmp, 'nope')).err)
    (Pathname.new(tmp) / 'emptydir').mkpath
    assert_match(/nothing to copy/, run_cli('files', File.join(tmp, 'emptydir')).err)
    assert_match(/at least one path/, run_cli('files').err)
    assert_empty dest.children
  end

  def test_e2e_mermaid_is_prerendered_to_inline_svg_and_needs_no_cdn
    skip 'mmdc not installed' unless tool?('mmdc')
    md = sample_md('m.md', "# M\n\n```mermaid\ngraph TD; A-->B;\n```\n")
    r = run_cli(md)
    assert r.ok?, r.err
    html = r.path.read
    assert_includes html, '<svg'
    refute_includes html, 'cdn.jsdelivr'
  end
end
