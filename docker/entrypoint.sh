#!/bin/bash
set -euo pipefail

cd /srv/jekyll

if ! bundle check >/dev/null 2>&1; then
  bundle install
fi

exec bundle exec jekyll serve \
  --force_polling \
  --host 0.0.0.0 \
  --watch \
  --livereload
