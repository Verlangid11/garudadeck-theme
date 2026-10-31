# GarudaDeck Installer

<p align="center">
  <img src="garudadeck-logo.png" width="180" alt="GarudaDeck logo by verlangid">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/panel-1.15.2-c8102e?style=for-the-badge" alt="panel">
  <img src="https://img.shields.io/badge/ubuntu-20.04_22.04_24.04-141414?style=for-the-badge" alt="ubuntu">
  <img src="https://img.shields.io/badge/debian-11_12-141414?style=for-the-badge" alt="debian">
  <img src="https://img.shields.io/badge/php-8.2_8.3-d4a017?style=for-the-badge" alt="php">
  <img src="https://img.shields.io/badge/install-bash_1_baris-35c26e?style=for-the-badge" alt="install">
</p>

<p align="center"><b>Installer Pterodactyl 1.15.2 original, bersih dari tema GarudaDeck.</b></p>

Installer satu perintah untuk memasang source panel Pterodactyl **1.15.2 penuh** dan menghapus seluruh sisa tema GarudaDeck dari panel. Nama installer tetap **GarudaDeck**, dibuat oleh **verlangid** dari Indonesia, lisensi MIT.

## Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
```

Menu angka:

1. Install panel original 1.15.2, bersih dari tema GarudaDeck
2. Cek VPS dan panel, tanpa mengubah apa pun
3. Backup kode plus database
4. Rollback kode dan database ke backup terakhir
5. Keluar

Aksi langsung:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) check
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) backup
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) rollback
```

Panel di path lain:

```bash
PANEL_DIR=/var/www/panel bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
```

## Yang dilakukan installer

1. Cek OS, PHP, panel, database, dan ruang disk.
2. Backup kode plus database ke `theme-backups/`.
3. Hapus semua sisa GarudaDeck: file tema, aset publik, route, controller, model, migrasi, tabel `announcements` dan `server_custom_domains`, serta baris migrasinya.
4. Ekstrak source Pterodactyl 1.15.2 penuh. Aset frontend sudah ikut paket, tanpa `yarn build`.
5. Jalankan `composer install` hanya bila `vendor` hilang atau `composer.lock` berubah.
6. Migrasi database, bersihkan cache, perbaiki permission dan symlink `public/storage`.
7. Verifikasi versi, manifest aset, CSS admin, syntax PHP, kebersihan database, dan memastikan `.env` tidak berubah.

## Yang dipertahankan

- `.env` panel tujuan, termasuk kredensial database dan `APP_URL`.
- Isi `storage/` dan `storage/app/public`.
- Data database selain tabel tema GarudaDeck.
- Fitur kustom non-tema: dashboard links, avatar, uptime samples, resource samples, SEO, dan konfigurasi panel lainnya.

## Syarat

- Ubuntu 20.04, 22.04, 24.04 atau Debian 11, 12.
- PHP 8.2 atau 8.3 dengan `pdo_mysql`.
- Panel Pterodactyl 1.11 sampai 1.15 di `PANEL_DIR`.
- `.env` berisi `DB_DATABASE` dan `DB_USERNAME`.
- Root atau sudo, ruang disk minimal 300 MB.
- Node dan yarn tidak dibutuhkan di VPS tujuan.

## Backup dan rollback

Backup disimpan di:

```text
/var/www/pterodactyl/theme-backups/pterodactyl-original-1.15.2-YYYYMMDD-HHMMSS/
```

Gagal di tengah install berarti rollback otomatis ke backup barusan. Rollback manual lewat menu nomor 4. Matikan rollback otomatis dengan `AUTO_ROLLBACK=0`.

## Lisensi

MIT. Dibuat oleh **verlangid** dari Indonesia.
