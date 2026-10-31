# GarudaDeck Installer

<p align="center">
  <img src="../garudadeck-logo.png" width="180" alt="GarudaDeck logo by verlangid">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/panel-1.15.2-c8102e?style=for-the-badge" alt="panel">
  <img src="https://img.shields.io/badge/ubuntu-20.04_22.04_24.04-141414?style=for-the-badge" alt="ubuntu">
  <img src="https://img.shields.io/badge/debian-11_12-141414?style=for-the-badge" alt="debian">
  <img src="https://img.shields.io/badge/php-8.2_8.3-d4a017?style=for-the-badge" alt="php">
  <img src="https://img.shields.io/badge/i18n-en_id-35c26e?style=for-the-badge" alt="i18n">
  <img src="https://img.shields.io/badge/install-1_command-35c26e?style=for-the-badge" alt="install">
</p>

<p align="center"><b>Garuda Deck panel 1.15.2 installer. Smart, fast, bilingual English and Indonesia.</b></p>

> English is first for global users. Indonesian docs follow in [README-ID.md](README-ID.md).

GarudaDeck installs a full **Garuda Deck 1.15.2** panel. Installer name stays **GarudaDeck**, MIT license.

Final result: photo login with Garuda Deck image, name **Garuda Deck** everywhere, website photo and icons replaced with Garuda Deck logo, title **Garuda Deck | Game Server & Application Hosting**, description **Garuda Deck, panel hosting server game dan aplikasi by verlangid from Indonesia**, watermark **Garuda Deck by verlangid from Indonesia** on login, client, server, and admin sides.

## Quick install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
```

Language menu appears first:

1. Indonesia (default)
2. English

Then action menu:

- `0` switch language
- `1` install Garuda Deck panel 1.15.2
- `2` check VPS and panel, change nothing
- `3` backup only, safe before changes
- `4` rollback to latest backup snapshot, code plus database
- `6` uninstall theme, full reverse of install, back to stock Pterodactyl default
- `5` exit

Direct actions still work:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) en install
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) check
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) backup
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) rollback
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) uninstall
```

Custom panel path:

```bash
PANEL_DIR=/var/www/panel bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
```

Force language without menu:

```bash
GARUDADECK_LANG=en bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) install
GARUDADECK_LANG=id bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) install
```

Quiet output:

```bash
QUIET=1 bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
```

## What the installer does

1. Smart check: VPS type, arch, OS, panel 1.11 to 1.15, PHP 8.2 or 8.3, `pdo_mysql`, `.env`, vendor, disk. Abort before any change on failure.
2. Automatic backup before changes. Automatic rollback on mid-install failure.
3. Remove all old theme leftovers completely.
4. Install full Garuda Deck 1.15.2 panel, no manual build.
5. Set Garuda Deck name, title, description, photo, website icons, migrate, clear cache, fix permissions.
6. Final verify: Garuda Deck name, photo, website icons, title, description, login watermark, client watermark, admin watermark.

## What is kept

- Target panel config.
- Storage contents and panel data.
- Existing settings are reused.

## Preview

Realtime screenshots from target VPS after 6 stage pass:

![login](../preview/panel/01-login.png)
![dashboard](../preview/panel/02-dashboard.png)
![account](../preview/panel/03-account.png)
![api](../preview/panel/04-api.png)
![ssh](../preview/panel/05-ssh.png)
![activity](../preview/panel/06-activity.png)
![admin overview](../preview/panel/07-admin-overview.png)
![admin settings](../preview/panel/08-admin-settings.png)
![admin users](../preview/panel/10-admin-users.png)
![admin servers](../preview/panel/11-admin-servers.png)
![admin nodes](../preview/panel/12-admin-nodes.png)
![admin nests](../preview/panel/13-admin-nests.png)
![admin databases](../preview/panel/14-admin-databases.png)
![admin locations](../preview/panel/15-admin-locations.png)
![admin mounts](../preview/panel/16-admin-mounts.png)

### Server GarudaCraft, Minecraft Paper

![console](../preview/server/console.png)
![files](../preview/server/files.png)
![file json](../preview/server/file-json.png)
![file sql](../preview/server/file-sql.png)
![databases](../preview/server/databases.png)
![startup egg](../preview/server/startup-egg.png)
![network](../preview/server/network.png)
![backups](../preview/server/backups.png)
![schedules](../preview/server/schedules.png)
![users](../preview/server/users.png)
![settings](../preview/server/settings.png)
![activity](../preview/server/activity.png)

More guides in [docs/](.): [INSTALL-EN.md](docs/INSTALL-EN.md), [INSTALL-ID.md](docs/INSTALL-ID.md), [COMPATIBILITY.md](docs/COMPATIBILITY.md), [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md).

## Requirements

- Ubuntu 20.04, 22.04, 24.04 or Debian 11, 12 by default. Smart mode warns but continues on other Linux when panel and PHP pass.
- PHP 8.2 or 8.3 with `pdo_mysql`.
- Panel 1.11 to 1.15.
- Root or sudo, at least 300 MB free disk.
- Node and yarn are not needed on target VPS.

## Backup, rollback, and uninstall

Backup is stored automatically before install. Manual rollback from menu number 4. Disable auto rollback with `AUTO_ROLLBACK=0`. Rollback restores an old backup snapshot of code plus database. Uninstall from menu number 6 is the realtime reverse of install: it strips all Garuda Deck files, restores stock Pterodactyl files, drops Garuda tables and migrations, resets name and SEO to default, keeps server and user data, and makes a safety backup first.

## Brand

Logo in [brand/](../brand/garudadeck-logo.png). Watermark text on every side: **Garuda Deck by verlangid from Indonesia**.

## License

MIT. Made by **verlangid** from Indonesia.
