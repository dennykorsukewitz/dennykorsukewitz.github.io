# Docker — Local Preview

Run a Jekyll preview without installing Ruby locally.

## Requirements

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (or Docker Engine + Compose plugin)
- Git submodules initialized

## First-time setup

```bash
cd dennykorsukewitz.github.io

git submodule update --init --recursive

docker compose up --build
```

| URL | Content |
| --- | --- |
| http://localhost:4000 | Home |
| http://localhost:4000/metrics/ | Metrics page |
| http://localhost:4000/posts/ | Posts |

LiveReload: port `35729` (file changes → auto-reload in the browser).

## Commands

```bash
# Start (foreground)
docker compose up

# Start (background)
docker compose up -d

# Stop
docker compose down

# Rebuild (after Gemfile changes)
docker compose build --no-cache
docker compose up
```

## Files

| File | Purpose |
| --- | --- |
| `Dockerfile` | Ruby 3.2, Bundler, gems from `Gemfile` |
| `docker-compose.yml` | Port mapping, volume mounts |
| `docker/entrypoint.sh` | `bundle install` + `jekyll serve` |
| `.dockerignore` | Build context without `_site`, cache |

## Volumes

```yaml
.:/srv/jekyll                              # Source code (live edit)
jekyll-cache:/srv/jekyll/.jekyll-cache     # Jekyll cache (container)
jekyll-site:/srv/jekyll/_site              # Build output (container)
```

`.jekyll-cache` and `_site` intentionally live **outside** the host mount — avoids permission issues between the container and macOS.

## What works locally / what does not

| Works | Limitation |
| --- | --- |
| Theme, layout, tabs | — |
| Manually maintained `_tabs/*.md` | — |
| Metrics charts | Requires internet (JSON from GitHub raw) |
| Metrics SVGs | External images from meta repo |
| Generated tabs/posts | Missing unless `pages.sh` is run |

To test local metrics data: push JSON to `dennykorsukewitz` on `dev` — or temporarily point URLs in `_tabs/metrics.md` at local files.

## Generated content locally

For a full production-like site:

```bash
# Requires GitHub CLI + token with repo access
export GITHUB_TOKEN=ghp_...

bash .github/workflows/pages/pages.sh
docker compose up
```

The `pages.sh` script runs all generation steps (see [Updating](updating.md)).

Without `gh`: only static tabs and manual files are visible. `_tabs/repositories.md`, `_posts/*`, and cloned repo folders will be missing.

## Troubleshooting

### Port 4000 already in use

Adjust `docker-compose.yml`:

```yaml
ports:
  - "4001:4000"
```

Then open: http://localhost:4001

### Missing submodule / broken theme

```bash
git submodule update --init --recursive
docker compose build --no-cache
docker compose up
```

### Gemfile changed

Rebuild the container:

```bash
docker compose build --no-cache && docker compose up
```

The entrypoint also runs `bundle install` on start when needed.

### Jekyll warnings "Conflict: destination shared"

Harmless — caused by duplicate tag/category paths from generated posts. Same behavior in production.
