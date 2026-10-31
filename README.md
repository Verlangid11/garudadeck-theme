# GarudaDeck Installer

<p align="center">
  <img src="garudadeck-logo.png" width="180" alt="GarudaDeck logo by verlangid">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/panel-1.15.2-c8102e?style=for-the-badge" alt="panel">
  <img src="https://img.shields.io/badge/ubuntu-20.04_22.04_24.04-141414?style=for-the-badge" alt="ubuntu">
  <img src="https://img.shields.io/badge/debian-11_12-141414?style=for-the-badge" alt="debian">
  <img src="https://img.shields.io/badge/php-8.2_8.3-d4a017?style=for-the-badge" alt="php">
  <img src="https://img.shields.io/badge/i18n-en_id-35c26e?style=for-the-badge" alt="i18n">
  <img src="https://img.shields.io/badge/install-1_command-35c26e?style=for-the-badge" alt="install">
</p>

<p align="center"><b>Smart fast Garuda Deck 1.15.2 installer. Bilingual: English and Indonesia.</b></p>

English: full guide in [docs/README-EN.md](docs/README-EN.md).
Indonesia: panduan penuh di [docs/README-ID.md](docs/README-ID.md).

One command installs full **Garuda Deck 1.15.2** panel. Installer name stays **GarudaDeck**, MIT license.

Result: photo login with Garuda Deck image, name **Garuda Deck** everywhere. Watermark on every side: **Garuda Deck by verlangid from Indonesia**, covering login, client, server, and admin.

## Install / Instal

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
```

Language menu first / Menu bahasa dulu:

- `[1]` Indonesia (default)
- `[2]` English

Action menu / Menu aksi: `0` language / bahasa, `1` install, `2` check / cek, `3` backup, `4` rollback, `5` exit / keluar.

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) en install
GARUDADECK_LANG=id bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) install
PANEL_DIR=/var/www/panel bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
QUIET=1 bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
```

## Structure / Struktur

Public repo layout is intentionally different from the private dist repo. Public only opens installer and theme focus, no internal paths.

- `install.sh`: smart bilingual wrapper via GHCR, no token.
- `docs/`: global guides, EN first then ID: `README-EN.md`, `README-ID.md`, `INSTALL-EN.md`, `INSTALL-ID.md`, `COMPATIBILITY.md`, `TROUBLESHOOTING.md`.
- `preview/panel/`: login, dashboard, account, admin screenshots.
- `preview/server/`: console, files, databases, startup, network proof.
- `brand/`: public logo copy.
- `assets/asli/`: original reference shots before Garuda Deck install.

Private repo keeps full build, payload, and release pipeline. Public repo never exposes private resources, internal paths, digests, tokens, or disk details.

## Preview

![login](preview/panel/01-login.png)
![dashboard](preview/panel/02-dashboard.png)
![console](preview/server/console.png)
![files](preview/server/files.png)
![admin](preview/panel/07-admin-overview.png)

Full sets: [preview/panel/](preview/panel/), [preview/server/](preview/server/).

## Requirements / Syarat

EN: Ubuntu 20.04, 22.04, 24.04 or Debian 11, 12 by default. Smart mode warns but continues on other Linux when panel and PHP pass. PHP 8.2 or 8.3, panel 1.11 to 1.15, root or sudo, 300 MB disk. No Node or yarn on target.

ID: Default Ubuntu 20.04, 22.04, 24.04 atau Debian 11, 12. Mode cerdas memberi peringatan tapi lanjut di Linux lain selama panel dan PHP lolos. PHP 8.2 atau 8.3, panel 1.11 sampai 1.15, root atau sudo, disk 300 MB. Node dan yarn tidak dibutuhkan.

## License / Lisensi

MIT. EN: Made by **verlangid** from Indonesia. ID: Dibuat oleh **verlangid** dari Indonesia.
