#!/bin/sh
# Installs everything ,md-to-html and ,md-to-pdf need, all through the GLOBAL mise install
# (mise is the only prerequisite). The md scripts run on that toolset via ,mise-global-exec, so
# project-local mise versions (e.g. ruby 2.7) are never touched or used.
#
# Idempotent and non-upgrading: anything already present in the global mise config is used as is,
# only what is missing gets installed (the latest version at that time). Re-running never bumps your
# global ruby/node/python, bundler or commonmarker; to upgrade one on purpose use
# `mise upgrade <tool>` / `mise use -g <tool>@<version>`. The exceptions are PlantUML and
# mermaid-cli (standalone renderers, not language runtimes): every run upgrades them to latest.
# Works on Linux (Debian/Fedora) and macOS (Apple Silicon).
#   - mise tools: ruby, node, github:plantuml/plantuml (optional; without it ```plantuml fences render as code)
#   - ruby gems:  bundler + commonmarker (the scripts use bundler/inline, this pre-installs the gem)
#   - npm:        @mermaid-js/mermaid-cli (mmdc + bundled puppeteer/Chromium, used by ,md-to-pdf),
#                 installed with the global node's npm — mise's npm: backend currently refuses it
#                 (trust-policy failure on the chromium-bidi dependency)
set -eu

say() { printf -- '-- %s\n' "$*"; }

command -v mise > /dev/null 2>&1 || { echo "mise not found — install it first: https://mise.jdx.dev" >&2; exit 1; }

# resolve mise tools from $HOME so only the global config applies, whatever directory this runs from
cd "$HOME"

# ensure_tool TOOL: keep the global version if one is configured and installed, else install latest
ensure_tool() {
  if mise where "$1" > /dev/null 2>&1; then
    say "$1: using $(mise where "$1")"
  else
    say "$1: not installed, installing latest"
    mise use -g "$1@latest"
  fi
}

say "mise tools (global)"
ensure_tool ruby
ensure_tool node
if mise use -g github:plantuml/plantuml@latest; then
  mise upgrade github:plantuml/plantuml
else
  echo "plantuml install failed — skipping (optional; plantuml fences will render as code)" >&2
fi

say "Ruby gems"
mise exec -- gem list -i '^bundler$' > /dev/null || mise exec -- gem install bundler
mise exec -- gem list -i '^commonmarker$' -v '~> 2.0' > /dev/null || mise exec -- gem install commonmarker -v '~> 2.0' || {
  echo "commonmarker failed to build — it needs libclang (Debian: sudo apt install libclang-dev, Fedora: sudo dnf install clang-devel, macOS: xcode-select --install)" >&2
  exit 1
}

say "Node packages"
# newer npm blocks install scripts by default; puppeteer's postinstall downloads Chromium
mise exec -- npm install -g --allow-scripts=puppeteer @mermaid-js/mermaid-cli@latest
mise reshim

say "Done"
