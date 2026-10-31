# Troubleshooting / Bantuan

## Panel not found / Panel tidak ketemu

EN: installer auto searches common paths. Set manually:

```bash
PANEL_DIR=/var/www/panel bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) check
```

ID: installer cari otomatis di path umum. Set manual:

```bash
PANEL_DIR=/var/www/panel bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) check
```

## Permission / Hak akses

EN: rerun as root or via sudo. The wrapper auto elevates when sudo exists.

ID: ulangi sebagai root atau via sudo. Wrapper otomatis naik hak bila sudo ada.

## PHP version / Versi PHP

EN: need 8.2 or 8.3. Check with:

```bash
php -v
php -m | grep -i pdo_mysql
```

ID: butuh 8.2 atau 8.3. Cek dengan:

```bash
php -v
php -m | grep -i pdo_mysql
```

## Package pull / Tarik paket gagal

EN: check connection, retry. Force API mode without docker:

```bash
GARUDADECK_FORCE_API=1 bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) install
```

ID: cek koneksi, ulangi. Paksa mode API tanpa docker:

```bash
GARUDADECK_FORCE_API=1 bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) install
```

## Rollback

EN: automatic on mid-install failure. Manual:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) rollback
```

EN: rollback restores old code plus database snapshot. Uninstall is different, it is the realtime reverse of install: strip all Garuda Deck and restore stock Pterodactyl default, server data kept:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) uninstall
```

ID: otomatis bila gagal di tengah install. Manual:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) rollback
```

ID: rollback mengembalikan snapshot lama kode plus database. Uninstall beda, ia kebalikan realtime dari install: copot semua Garuda Deck dan kembali ke Pterodactyl default, data server tetap:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) uninstall
```
