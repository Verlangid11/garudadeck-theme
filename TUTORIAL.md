# Tutorial GarudaDeck pakai bash, 5 menit
Repo full private, install hanya lewat installer via GHCR public tanpa token. Tidak ada download manual dari GitHub.
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
Cocok bila panel 1.11 sampai 1.15, PHP 8.2 atau 8.3, OS Ubuntu 20.04, 22.04, 24.04, Debian 11, 12.
## 3. Cek kompatibilitas via installer
```bash
curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh | bash -s -- check
```
## 4. Install via GHCR
```bash
curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh | bash
```
Installer otomatis unduh oras sekali pakai, pull ghcr.io/verlangid11/garudadeck-theme:1.15.2 tanpa token, lalu pasang tema, backup, branding, migrasi, dan verifikasi.
## 5. Buka panel
Refresh browser, logo GarudaDeck muncul di login dan favicon tab. Login admin, buka menu Pengumuman.
## 6. Bila error
```bash
curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh | bash -s -- rollback
```
