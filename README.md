# GarudaDeck Theme
<p align="center"><img src="garudadeck-logo.png" width="180" alt="GarudaDeck logo by verlangid"></p>
Tema Pterodactyl by **verlangid** dari Indonesia. Repo source full private, install hanya lewat installer bash via package GHCR public tanpa token.
Custom domain per server dengan verifikasi DNS asli plus pengumuman global. Support panel 1.11 sampai 1.15, Ubuntu 20.04, 22.04, 24.04, Debian 11, 12, PHP 8.2, 8.3.
## Install 1 menit pakai bash tanpa token
```bash
curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-dist/main/install.sh | bash
```
Tunggu sampai muncul `selesai. Backup aman di ...`. Logo GarudaDeck muncul di login dan favicon tab.
## Aksi lain
```bash
curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-dist/main/install.sh | bash -s -- check
curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-dist/main/install.sh | bash -s -- backup
curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-dist/main/install.sh | bash -s -- rollback
```
## Panel beda folder dan versi lain
```bash
PANEL_DIR=/var/www/panel curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-dist/main/install.sh | bash -s -- install
GARUDADECK_TAG=1.15.2 curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-dist/main/install.sh | bash
```
## Kenapa aman dan private
- Repo garudadeck-theme full private, buka di browser tanpa akses balas 404.
- Repo ini hanya etalase promo berisi teks, logo, dan installer kecil. Tidak ada file tema asli di sini.
- Payload tema hanya ada di package ghcr.io/verlangid11/garudadeck-theme yang public khusus package, pola sama seperti verlang docker. Orang tidak bisa download dari GitHub repo, hanya bisa tarik lewat installer bash.
- Contoh file di sini hanya tipuan struktur agar terlihat rapi, bukan source asli.
## Syarat VPS
- OS Ubuntu 20.04, 22.04, 24.04, Debian 11, 12
- Panel Pterodactyl original 1.11 sampai 1.15 di `/var/www/pterodactyl`
- PHP 8.2 atau 8.3, curl, tar, python3 wajib
- composer bila vendor hilang, rsync untuk rollback, yarn opsional
## Lihat demo dan tutorial
- Tutorial: TUTORIAL.md
- Contoh struktur: examples/
- Screenshot: assets/
