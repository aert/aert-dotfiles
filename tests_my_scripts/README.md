# tests_my_scripts

Automated tests for the scripts in `my_scripts/` (Ruby, [minitest](https://github.com/minitest/minitest)).
Currently covered: **`,mobile-review`** (`mobile_review/`). `,clean-filename` keeps its own harness,
`my_scripts/,clean-filename-tester`.

## Run

```bash
tests_my_scripts/run                              # everything (~15 s)
tests_my_scripts/run mobile_review                # one script's suite
tests_my_scripts/run mobile_review/unit           # one layer: fast (<1 s), no CLI runs
tests_my_scripts/run mobile_review/e2e/commit_test.rb
tests_my_scripts/run mobile_review -n /tig/       # anything starting with `-` goes to minitest (-n, --seed, -v)
tests_my_scripts/run --list                       # suites and files
```

The runner uses the global mise ruby (like the scripts). Tests that need chromium (PDF) or `mmdc` (mermaid)
are **skipped** when those are missing.

## Layout

```
tests_my_scripts/
├── run                          # runner (see above)
├── support/common.rb            # generic helpers for every suite: scratch dir, git, write, children, tool?
└── mobile_review/               # one directory per script under test: <script name with _ instead of - >
    ├── support.rb               # script-specific helpers: run_cli, build_repo (fixture git repo), page_* readers
    ├── unit/                    # `load` the script and call its methods directly; fast
    │   ├── naming_test.rb           classify by extension, timestamp, collisions, slugs, Syncthing temp names
    │   ├── diff_parsing_test.rb     header paths, markdown files of a diff, shebang hints, main/master, common parent
    │   ├── markdown_links_test.rb   link rewriting between rendered markdown files, JSON embedding
    │   └── output_test.rb           converter output is captured, closed pipes are fine
    └── e2e/                     # run the real CLI in scratch git repos with a scratch --dest
        ├── commit_test.rb               diff --commit: all markdown files, committed versions, page, errors, tig regression
        ├── working_and_range_test.rb    diff --working (untracked files), --range, stdin
        ├── inputs_and_files_test.rb     implicit md/pdf/image mode, md, files, destination, dry runs
        └── pdf_test.rb                  PDF output
```

Test files are `*_test.rb`; test methods are named `test_unit_...` / `test_e2e_...` so `-n /e2e/` or `-n /unit/`
selects a layer across files, and the name says what behaviour is protected.

## Rules (also in `AGENTS.md`)

1. **Changed a script that has a suite? Run its suite before you finish** (`tests_my_scripts/run <script>`), and
   say so in your summary. Don't leave it red.
2. **Changed behaviour or a CLI flag? Update the tests in the same change**, then the docs (see the list in
   `AGENTS.md`). A test that no longer describes the behaviour must be edited, not deleted to get green.
3. **Fixing a bug? Write the failing test first** (a regression test named after the symptom), watch it fail,
   then fix. Good examples: `test_e2e_survives_a_reader_that_closes_stdout_after_the_first_line_like_tig`
   (tig's `+` keeps only the first line of output and closes the pipe), the mnemonic-prefix and all-zero-id tests.
4. **New script in `my_scripts/`?** Add `tests_my_scripts/<script_name_with_underscores>/` with `support.rb`
   and at least the main happy path and the error cases. Reuse `support/common.rb`.
5. Tests must be hermetic: scratch dirs only (`tmp`, `dest`), never `~/Sync/...` or the repo's own working tree.
   E2E tests deliberately use *your* global git config (`diff.mnemonicPrefix=true` once broke path parsing).
6. Keep them fast: prefer a unit test; share one fixture repo (`build_repo`) instead of building bespoke ones.
   Avoid wall-clock dependence (timestamps have minute resolution; a run may or may not cross a minute boundary).

## Adding a test, in practice

```ruby
# tests_my_scripts/mobile_review/e2e/commit_test.rb
def test_e2e_my_new_behaviour
  repo = build_repo                                  # proj/ with a base commit and a HEAD commit
  r = run_cli('diff', '--commit', 'HEAD', cwd: repo) # real CLI, scratch --dest
  assert r.ok?, r.err
  assert_equal %w[00_diff.html README.html], children(r.path)
end
```

To check that a new regression test really protects the fix, temporarily undo the fix and watch the test fail.
