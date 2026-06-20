# Documentation

Documentation for [dennykorsukewitz.github.io](https://dennykorsukewitz.github.io).

| Document | Contents |
| --- | --- |
| [Site Structure](site-structure.md) | Layout, directories, repos, workflows |
| [Docker](docker.md) | Local preview without Ruby |
| [Updating](updating.md) | Content, metrics, deploy, screenshots |

## Repositories

| Repository | Role |
| --- | --- |
| [dennykorsukewitz.github.io](https://github.com/dennykorsukewitz/dennykorsukewitz.github.io) | Jekyll site (Chirpy), GitHub Pages |
| [dennykorsukewitz](https://github.com/dennykorsukewitz/dennykorsukewitz) | Metrics data (JSON), SVG charts, meta workflows |

## Quick start (local)

```bash
git submodule update --init --recursive
docker compose up --build
```

→ http://localhost:4000

Details: [Docker](docker.md)
