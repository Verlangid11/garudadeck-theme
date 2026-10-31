# Tutorial GarudaDeck Installer

## 1. Masuk VPS

```bash
ssh user@ip-vps-kamu
```

## 2. Cek panel

```bash
grep "'version'" /var/www/pterodactyl/config/app.php
php -v | head -1
cat /etc/os-release | head -2
```

## 3. Cek kompatibilitas

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) check
```

## 4. Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
```

Pilih nomor 1. Installer akan backup kode plus database, menghapus seluruh sisa tema GarudaDeck, memasang source Pterodactyl 1.15.2 original, lalu memverifikasi hasilnya. Aset frontend sudah ikut paket, jadi tidak ada `yarn build`.

## 5. Buka panel

Refresh browser. Panel kembali memakai tampilan Pterodactyl original. Menu Pengumuman dan Domain kustom sudah tidak ada karena semua bagian tema GarudaDeck dihapus.

## 6. Bila error

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) rollback
```

Atau pilih menu nomor 4. Rollback memulihkan kode dan database dari backup terakhir.
