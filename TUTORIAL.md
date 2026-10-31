# Tutorial GarudaDeck Installer

Installer satu perintah untuk memasang panel **Garuda Deck 1.15.2**: berfoto Garuda Deck di login, bernama Garuda Deck di semua tampilan, favicon ikut foto.

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

Butuh panel 1.11 sampai 1.15, PHP 8.2 atau 8.3, OS Ubuntu 20.04, 22.04, 24.04 atau Debian 11, 12.

## 3. Cek kompatibilitas

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) check
```

Tidak mengubah apa pun. Bila gagal, perbaiki pesan yang muncul lalu ulangi.

## 4. Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
```

Pilih nomor 1. Installer akan backup kode plus database, menghapus seluruh sisa tema lama, memasang panel Garuda Deck 1.15.2, set nama ke Garuda Deck, lalu memverifikasi hasilnya. Aset frontend sudah ikut paket, jadi tidak ada `yarn build`.

Output ringkas tanpa detail teknis:

```bash
QUIET=1 bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
```

## 5. Buka panel

Refresh browser. Login tampil foto Garuda Deck, nama tampil **Garuda Deck** di login, sidebar admin, tab browser, dan footer. Menu Pengumuman dan Domain kustom sudah tidak ada karena semua bagian tema lama dihapus.

Bila nama masih nama lama, buka Admin lalu simpan nama **Garuda Deck** sekali, atau jalankan install ulang.

## 6. Ganti foto final

Timpa file ini dengan PNG persegi foto final:

```text
public/garudadeck-logo.png
```

Refresh browser, tidak perlu rebuild. Favicon ikut foto bawaan paket, ganti manual bila perlu.

## 7. Bila error

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) rollback
```

Atau pilih menu nomor 4. Rollback memulihkan kode dan database dari backup terakhir. Gagal di tengah install juga otomatis rollback.
