# Backup to GitHub

## First-time: create repo and push

1. **Create a new repository on GitHub**
   - Go to https://github.com/new
   - Name it (e.g. `home-assistant` or `ha-config`)
   - Choose **Private** if you prefer (recommended for config)
   - Do **not** add a README, .gitignore, or license (this repo already has them)

2. **Set your Git identity** (if not already set globally):
   ```bash
   git config --global user.email "your-email@example.com"
   git config --global user.name "Your Name"
   ```
   For this repo only (optional):
   ```bash
   cd /home/rolki/projects/home-assistant
   git config user.email "your-email@example.com"
   git config user.name "Your Name"
   ```

3. **Add GitHub as remote and push** (replace with your repo URL):
   ```bash
   cd /home/rolki/projects/home-assistant
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
   git branch -M main
   git push -u origin main
   ```
   If you use SSH:
   ```bash
   git remote add origin git@github.com:YOUR_USERNAME/YOUR_REPO.git
   git branch -M main
   git push -u origin main
   ```

## Later: backup changes

```bash
cd /home/rolki/projects/home-assistant
git add .
git status
git commit -m "Update HA config"
git push
```

## What’s backed up (in git)

- YAML config: `configuration.yaml`, `automations.yaml`, `scripts.yaml`, `scenes.yaml`
- Dashboards: `config/dashboards/`
- Themes: `config/themes/`
- Custom components: `config/custom_components/` (HACS, Salus, etc.)
- Blueprints: `config/blueprints/`
- Docs: `config/*.md`, `README.md`

## What’s not in git (by design)

- **config/secrets.yaml** – Copy from `config/secrets.example.yaml` and fill in; never commit.
- **config/.storage/** – Auth, tokens, entity/device registry. Use **Settings → System → Backups** in HA for full backups.
- **config/*.db**, **config/*.log** – Runtime files.

## Restore on a new machine

1. Clone the repo.
2. Copy `config/secrets.example.yaml` to `config/secrets.yaml` and add your secrets.
3. Run `docker compose up -d`.
4. In HA: re-add integrations (or restore a full HA backup that includes `.storage`).
