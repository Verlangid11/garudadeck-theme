# Tutorial GarudaDeck 5 menit
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
curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh | bash -s -- check
```
## 4. Install
```bash
curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh | bash
```
## 5. Buka panel lalu login admin
Refresh browser, logo GarudaDeck muncul di login dan favicon tab. Buka menu Pengumuman untuk coba banner global, buka salah satu server untuk coba console, file manager, database, backup, jadwal, dan domain kustom.
## 6. Bila error
```bash
curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh | bash -s -- rollback
```
