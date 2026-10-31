# Install Guide EN

## 1. Enter VPS

```bash
ssh user@your-vps-ip
```

## 2. Compatibility check

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) en check
```

Changes nothing. On failure, fix the message then retry.

Smart behavior:

- Detects VPS virtualization and arch, prints it before checks.
- Default OS: Ubuntu 20.04, 22.04, 24.04, Debian 11, 12.
- Extended and unknown Linux: warning only, continue when panel 1.11 to 1.15 and PHP 8.2 or 8.3 pass.
- Auto searches panel in common paths plus up to 4 levels under `/var/www`, `/srv`, `/opt`, `/home`.

## 3. Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
```

Choose language first, then number 1.

Force English without menu:

```bash
GARUDADECK_LANG=en bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) install
```

## 4. Open panel

Refresh browser. Photo login with Garuda Deck image, name **Garuda Deck**, watermark **Garuda Deck by verlangid from Indonesia**.

## 5. On error

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) rollback
```

Or choose menu number 4. Rollback restores old code plus database snapshot.

## 6. Uninstall theme, keep data

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) uninstall
```

Or choose menu number 6. Uninstall is the realtime reverse of install: delete all Garuda Deck builds, install official vanilla Pterodactyl 1.15.2, no photo, no watermark, no announcement, no custom domain, server data kept, safety backup first.

## Notes

- `.env`, storage, and target database are kept, except panel name set to Garuda Deck.
- Backup stored safely, rollback available.
- No token needed, package comes from public GHCR.
