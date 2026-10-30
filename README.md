# GarudaDeck Theme

<p align="center">
  <img src="garudadeck-logo.png" width="180" alt="GarudaDeck logo by verlangid">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/panel-1.11--1.15-c8102e?style=for-the-badge" alt="panel">
  <img src="https://img.shields.io/badge/ubuntu-20.04_22.04_24.04-141414?style=for-the-badge" alt="ubuntu">
  <img src="https://img.shields.io/badge/debian-11_12-141414?style=for-the-badge" alt="debian">
  <img src="https://img.shields.io/badge/php-8.2_8.3-d4a017?style=for-the-badge" alt="php">
  <img src="https://img.shields.io/badge/install-bash_1_baris-35c26e?style=for-the-badge" alt="install">
</p>

<p align="center"><b>Tema Pterodactyl buatan verlangid dari Indonesia.</b> Repo source full private, install hanya lewat installer bash via package GHCR public tanpa token.</p>

<p align="center">Domain kustom per server dengan cek DNS asli plus papan pengumuman global. Warna merah Garuda <code>#c8102e</code>, emas <code>#d4a017</code>, krem <code>#f5f1e8</code>, gelap <code>#141414</code>.</p>

## Bukti asli dari panel live

Screenshot di bawah adalah capture nyata dari `client.timpapanel.web.id` tanggal 30 Okt 2026, bukan mockup. Logo GarudaDeck 36px sudah kepasang di kiri atas berdampingan dengan teks TIMPAPANEL, favicon 200 OK, build frontend sukses.

<p align="center">
  <img src="assets/asli/login-asli-timpapanel-1280.png" width="800" alt="Capture asli login timpapanel dengan logo GarudaDeck">
</p>

<p align="center">
  <img src="assets/asli/logo-asli-zoom.png" alt="Zoom logo GarudaDeck asli di panel">
</p>

Catatan jujur: nama brand di panel masih TIMPAPANEL karena `APP_NAME` di `.env` belum diganti ke GarudaDeck. File logo dan komponen `GarudaLogo.tsx` sudah asli terpasang, 2 tag img garudadeck terdeteksi Playwright. Setelah ganti nama repo sesuai permintaan kamu, brand akan saya samakan jadi GarudaDeck agar screenshot berikutnya murni.

## Install 1 menit pakai bash tanpa token

```bash
curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh | bash
```

Contoh sukses:

```text
[garudadeck] GarudaDeck via GHCR public, paket ghcr.io/verlangid11/garudadeck-theme:1.15.2
[garudadeck-check] OS didukung
[garudadeck-check] panel: 1.15.2
[garudadeck-check] PHP didukung
[garudadeck-backup] selesai: /var/www/pterodactyl/theme-backups/...
[garudadeck-install] selesai. Backup aman di ...
```

## Cek, backup, rollback

```bash
curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh | bash -s -- check
curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh | bash -s -- backup
curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh | bash -s -- rollback
```

Panel beda folder:

```bash
PANEL_DIR=/var/www/panel curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh | bash -s -- install
```

## Fitur utama

- Domain kustom per server, cek TXT `_garuda` dan A, cek ulang tiap 30 menit
- Papan pengumuman admin dengan sort terkecil menang, banner ikut warna tema
- Backup kode plus database dulu, gagal otomatis rollback
- Logo Garuda di login, favicon 33 file, komponen GarudaLogo
- Bahasa EN dan ID sinkron, tidak campur kode

## Syarat VPS

- OS: Ubuntu 20.04, 22.04, 24.04, Debian 11, 12
- Panel Pterodactyl original 1.11 sampai 1.15 di `/var/www/pterodactyl`
- PHP 8.2 atau 8.3, curl, tar, python3 wajib

## Kenapa aman dan private

- Repo `garudadeck-dist` full private, raw balas 404 tanpa akses
- Repo ini hanya etalase promo berisi teks, logo, installer kecil, dan bukti screenshot asli
- Payload tema hanya di package `ghcr.io/verlangid11/garudadeck-theme` public khusus package, pola sama seperti verlang docker
- Contoh di `examples/` hanya struktur untuk dokumentasi, bukan source asli

## Rencana tukar nama repo

Sesuai permintaan kamu: repo public sekarang `garudadeck-theme`, repo private sekarang `garudadeck-dist`. Swap sudah selesai via API.

## Dokumen lain

- Tutorial: TUTORIAL.md
- Contoh struktur: examples/theme-structure.txt
