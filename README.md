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

<p align="center"><b>Installer panel Garuda Deck 1.15.2, berfoto Garuda Deck dan bernama Garuda Deck.</b></p>

Installer satu perintah untuk memasang panel **Garuda Deck 1.15.2 penuh** dan menghapus seluruh sisa tema lama dari panel. Nama installer tetap **GarudaDeck**, lisensi MIT.

Hasil akhir: login memakai foto Garuda Deck, nama tampil **Garuda Deck** di login, admin, tab browser, dan SEO, favicon ikut foto Garuda Deck.

## Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
```

Menu angka:

1. Install panel Garuda Deck 1.15.2
2. Cek VPS dan panel, tanpa mengubah apa pun
3. Backup saja, aman sebelum ubah
4. Rollback ke backup terakhir
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

Mode hemat info (output ringkas, tanpa detail teknis):

```bash
QUIET=1 bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
```

## Yang dilakukan installer

1. Cek OS, PHP, panel, database, dan ruang disk. Gagal berarti batal sebelum ubah apa pun.
2. Backup kode plus database. Otomatis rollback bila gagal di tengah jalan.
3. Hapus semua sisa tema lama: file tema, aset publik, route, controller, model, migrasi, dan tabel tema.
4. Ekstrak panel Garuda Deck 1.15.2 penuh. Aset frontend sudah ikut paket, tanpa `yarn build`.
5. Jalankan `composer install` hanya bila `vendor` hilang atau `composer.lock` berubah.
6. Migrasi database, set nama panel ke **Garuda Deck**, bersihkan cache, perbaiki permission dan symlink storage.
7. Verifikasi versi, foto logo, favicon, tampilan login, manifest aset, CSS admin, syntax PHP, kebersihan database, nama Garuda Deck, dan `.env` tidak berubah.

Installer cerdas: deteksi panel otomatis di path umum, validasi versi 1.11 sampai 1.15, tolak OS dan PHP yang tidak didukung, coba pasang `rsync` dan client database otomatis, retry unduhan paket, dan pesan error ramah tanpa detail private.

## Yang dipertahankan

- `.env` panel tujuan, kecuali nama panel diset ke Garuda Deck.
- Isi `storage/` dan data database selain tabel tema lama.
- Fitur kustom non-tema: dashboard links, avatar, uptime samples, resource samples, SEO, dan konfigurasi panel lainnya.

## Syarat

- Ubuntu 20.04, 22.04, 24.04 atau Debian 11, 12.
- PHP 8.2 atau 8.3 dengan `pdo_mysql`.
- Panel 1.11 sampai 1.15.
- Root atau sudo, ruang disk minimal 300 MB.
- Node dan yarn tidak dibutuhkan di VPS tujuan.

## Backup dan rollback

Backup tersimpan otomatis sebelum install. Gagal di tengah install berarti rollback otomatis ke backup barusan. Rollback manual lewat menu nomor 4. Matikan rollback otomatis dengan `AUTO_ROLLBACK=0`.

## Ganti foto

Foto default ada di `public/garudadeck-logo.png`. Untuk ganti foto final, timpa file itu dengan PNG persegi, lalu refresh browser. Tidak perlu rebuild, tampilan login langsung memakai file baru dengan fallback huruf bila file hilang.

## Lisensi

MIT. Dibuat oleh **verlangid** dari Indonesia.
