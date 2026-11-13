# Home Assistant setup

Home Assistant configuration and dashboards. Runs via Docker Compose.

## Contents

- **config/** – HA config (YAML, dashboards, themes, custom components)
- **docker-compose.yaml** – Run HA in Docker

## What’s in git

- `configuration.yaml`, `automations.yaml`, `scripts.yaml`, `scenes.yaml`
- `config/dashboards/` – Lovelace YAML dashboards
- `config/themes/` – Themes
- `config/custom_components/` – HACS and custom integrations (HACS, Salus iT600 Cloud, etc.)
- `config/blueprints/` – Automation/script blueprints
- Docs: `config/*.md`

## What’s not in git

- **config/secrets.yaml** – Use `config/secrets.example.yaml` as a template; never commit secrets.
- **config/.storage/** – Auth, tokens, entity/device registry (restore from HA backup or re-add integrations).
- **config/*.db**, **config/*.log** – Runtime files.

## First-time / restore

1. Clone this repo.
2. Copy `config/secrets.example.yaml` to `config/secrets.yaml` and add your secrets.
3. Start: `docker compose up -d`
4. Open HA, complete onboarding if needed, and re-add integrations (or restore `.storage` from a backup if you have one).

## Run

```bash
docker compose up -d
```

Restart:

```bash
docker compose restart homeassistant
```

## Backup to GitHub

- See **[BACKUP.md](BACKUP.md)** for creating the GitHub repo and pushing.
- Config is backed up by committing to git (see above for what’s tracked).
- For a full backup (including `.storage` and DB), use **Settings → System → Backups** in Home Assistant, or copy the whole `config/` folder elsewhere.

## Validate

Check the config with the official Home Assistant checker before pushing. Run it on a copy of `config/`, because Home Assistant may write runtime files into the mounted folder:

```bash
tmp=$(mktemp -d)
git archive HEAD config | tar -x -C "$tmp"
docker run --rm -v "$tmp/config":/config ghcr.io/home-assistant/home-assistant:stable python -m homeassistant --script check_config -c /config
```

It prints `Testing configuration at /config` and exits 0 when the config is valid. Any other exit code means it is broken. The `check-config` GitHub Actions workflow runs the same check on pull requests and pushes to `master`.
