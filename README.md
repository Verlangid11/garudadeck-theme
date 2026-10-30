# GarudaDeck Theme
<p align="center"><img src="garudadeck-logo.png" width="180" alt="GarudaDeck logo by verlangid"></p>
Tema Pterodactyl open source by **verlangid** dari Indonesia, lisensi MIT.
Custom domain per server dengan verifikasi DNS asli plus pengumuman global, UI bersih, install satu baris.
Panel 1.11 sampai 1.15, Ubuntu 20.04, 22.04, 24.04, Debian 11, 12, PHP 8.2, 8.3.
## Install 1 menit pakai bash
Jalankan di VPS sebagai user biasa atau root, tanpa download manual. Script auto sudo sendiri:
```bash
curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-dist/main/install.sh | bash
```
Tunggu sampai muncul `selesai. Backup aman di ...`. Buka panel kamu, logo GarudaDeck muncul di login dan tab browser.
Contoh output sukses:
```
[garudadeck] GarudaDeck public dist, repo Verlangid11/garudadeck-dist, panel /var/www/pterodactyl, aksi install
[garudadeck-check] OS didukung
[garudadeck-check] panel: 1.15.2
[garudadeck-check] PHP didukung
[garudadeck-backup] selesai: /var/www/pterodactyl/theme-backups/...
[garudadeck-install] selesai. Backup aman di ...
```
## Cek dulu sebelum install
```bash
curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-dist/main/install.sh | bash -s -- check
```
Lolos bila muncul `cek lolos, lanjut backup` plus OS, panel, PHP didukung.
## Backup manual
```bash
curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-dist/main/install.sh | bash -s -- backup
```
Hasil di `/var/www/pterodactyl/theme-backups` berisi kode plus database plus MANIFEST.
## Rollback bila gagal atau tidak cocok
```bash
curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-dist/main/install.sh | bash -s -- rollback
```
Panel kembali ke backup terbaru, logo Garuda dibersihkan otomatis, database dikembalikan bila ada arsipnya. Installer juga auto rollback bila gagal di tengah jalan.
## Panel beda folder
```bash
PANEL_DIR=/var/www/panel curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-dist/main/install.sh | bash -s -- install
```
## Tanpa rollback otomatis
```bash
AUTO_ROLLBACK=0 curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-dist/main/install.sh | bash
```
## Syarat VPS
- OS: Ubuntu 20.04, 22.04, 24.04, Debian 11, 12
- Panel Pterodactyl original 1.11 sampai 1.15 di `/var/www/pterodactyl`
- PHP 8.2 atau 8.3, curl, tar, python3 wajib
- composer bila vendor hilang, rsync untuk rollback, yarn opsional untuk build
- Akses tulis ke folder panel, jalankan sebagai root atau user dengan sudo
## Yang dilakukan installer
1. Cek OS, versi panel, PHP, tool wajib. Gagal berhenti sebelum ubah apa pun.
2. Backup kode plus database ke `theme-backups` dengan MANIFEST.
3. Pasang file tema, logo, favicon 33 file, patch login, patch route idempoten.
4. Migrasi database force, bersihkan cache, build frontend bila yarn ada.
5. Verifikasi syntax model dan route pengumuman. Gagal otomatis rollback.
## Keamanan source
Repo source di `garudadeck-theme` private, raw file 404 tanpa akses. Repo ini hanya berisi installer public plus tarball build 8 MB. Tarball bersih tanpa password, token, env, atau key. Yang terlihat publik hanya hasil build agar installer bisa pasang, bukan history commit dan kode privat lain.
