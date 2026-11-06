# frozen_string_literal: true

# Helpers for the ,mobile-review tests: running the CLI, building fixture git repos, reading the pages it writes.
# Every test file in this directory starts with `require_relative '../support'`.

require_relative '../support/common'

SCRIPT = File.expand_path('../../my_scripts/,mobile-review', __dir__)
load SCRIPT # defines MobileReview & co; its `main` only runs when it is the program, not when loaded here

# 1x1 PNG
PNG = 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg=='.unpack1('m').freeze
PNG_B64_PREFIX = 'iVBORw0KGgo'

Result = Struct.new(:out, :err, :status) do
  def ok? = status.zero?
  def lines = out.lines.map(&:chomp)
  def path = Pathname.new(lines.last.to_s) # the one line the script prints: what it wrote
end

module MobileReviewHelpers
  include TestSupport

  def review(**opts)
    MobileReview.new(dest: dest.to_s, simulate: false, name: nil, pdf: false, **opts)
  end

  # Runs the real CLI (`ruby ,mobile-review --dest <dest> ARGS`) in cwd. Uses YOUR global git config on
  # purpose (diff.mnemonicPrefix=true once broke path parsing). Never touches the real Syncthing folder.
  def run_cli(*args, cwd: nil, dest_dir: dest, stdin: '')
    cmd = [RbConfig.ruby, SCRIPT]
    cmd += ['--dest', dest_dir.to_s] if dest_dir
    out, err, status = Open3.capture3(*cmd, *args, chdir: (cwd || tmp).to_s, stdin_data: stdin)
    Result.new(out, err, status.exitstatus)
  end

  # proj/ with two commits on `branch`:
  #   base:   README.md (include + links), inc/part.md, docs/guide.md (+ image), docs/img/a.png, other/README.md,
  #           old.md, run (ruby shebang), pytool (python shebang), notes.txt
  #   second: edits README/part/guide/other README/run, deletes old.md   <- HEAD ("the commit under review")
  def build_repo(root: tmp, branch: 'main')
    repo = Pathname.new(root).join('proj').tap(&:mkpath)
    git(repo, 'init', '-q', '-b', branch)
    %w[user.email=t@t user.name=Tester commit.gpgsign=false].each { |kv| git(repo, 'config', *kv.split('=', 2)) }
    write(repo, 'README.md', "# Root v1\n\n<!-- include: inc/part.md -->\n\nSee [guide](docs/guide.md#top) and [other](other/README.md).\n")
    write(repo, 'inc/part.md', "part v1\n")
    write(repo, 'docs/guide.md', "# Guide\n\n![a](img/a.png)\n\nBack to [root](../README.md).\n")
    write(repo, 'docs/img/a.png', PNG)
    write(repo, 'other/README.md', "# Other readme\n")
    write(repo, 'old.md', "# gone\n")
    write(repo, 'run', "#!/usr/bin/env ruby\nputs 1\n", mode: 0o755)
    write(repo, 'pytool', "#!/usr/bin/env python3\nprint(1)\n", mode: 0o755)
    write(repo, 'notes.txt', "plain\n")
    git(repo, 'add', '-A')
    git(repo, 'commit', '-q', '-m', 'base')
    write(repo, 'README.md', "# Root v2 (COMMITTED)\n\n<!-- include: inc/part.md -->\n\nSee [guide](docs/guide.md#top) and [other](other/README.md).\n")
    write(repo, 'inc/part.md', "part v2 (COMMITTED)\n")
    File.open(repo.join('docs/guide.md'), 'a') { |f| f.puts "\nMore guide v2.\n" }
    File.open(repo.join('other/README.md'), 'a') { |f| f.puts "\nOther v2.\n" }
    File.open(repo.join('run'), 'a') { |f| f.puts 'puts 2' }
    git(repo, 'rm', '-q', 'old.md')
    git(repo, 'add', '-A')
    git(repo, 'commit', '-q', '-m', 'second')
    repo
  end

  # The diff page embeds the patch and a config object as JSON in <script type="application/json"> tags.
  def page_json(html, id)
    JSON.parse(html[%r{<script id="#{id}" type="application/json">(.*?)</script>}m, 1])
  end

  def page_patch(folder_or_file)
    file = Pathname.new(folder_or_file)
    file = file.join('00_diff.html') if file.directory?
    page_json(file.read, 'patch')
  end

  def page_config(folder)
    page_json(Pathname.new(folder).join('00_diff.html').read, 'config')
  end

  # Syncthing temp files (.syncthing.<name>.tmp) must all have been renamed to their final names.
  def no_temp_leftovers!(dir)
    leftovers = Dir.glob('**/.syncthing.*', File::FNM_DOTMATCH, base: dir.to_s)
    assert_empty leftovers, 'temporary .syncthing.*.tmp files must be renamed away'
  end
end
