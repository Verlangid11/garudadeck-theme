# GarudaDeck Installer

<p align="center">
  <img src="../garudadeck-logo.png" width="180" alt="Logo GarudaDeck oleh verlangid">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/panel-1.15.2-c8102e?style=for-the-badge" alt="panel">
  <img src="https://img.shields.io/badge/ubuntu-20.04_22.04_24.04-141414?style=for-the-badge" alt="ubuntu">
  <img src="https://img.shields.io/badge/debian-11_12-141414?style=for-the-badge" alt="debian">
  <img src="https://img.shields.io/badge/php-8.2_8.3-d4a017?style=for-the-badge" alt="php">
  <img src="https://img.shields.io/badge/i18n-id_en-35c26e?style=for-the-badge" alt="i18n">
  <img src="https://img.shields.io/badge/install-1_perintah-35c26e?style=for-the-badge" alt="install">
</p>

<p align="center"><b>Installer panel Garuda Deck 1.15.2. Cerdas, cepat, bilingual Indonesia dan English.</b></p>

GarudaDeck memasang panel **Garuda Deck 1.15.2** penuh. Nama installer tetap **GarudaDeck**, lisensi MIT.

Hasil akhir: login berfoto Garuda Deck, nama **Garuda Deck** di semua sisi, foto dan ikon website diganti logo Garuda Deck, judul **Garuda Deck | Game Server & Application Hosting**, deskripsi **Garuda Deck, panel hosting server game dan aplikasi by verlangid from Indonesia**, watermark **Garuda Deck by verlangid from Indonesia** di login, client, server, dan admin.

## Install cepat

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
```

Menu bahasa muncul dulu:

1. Indonesia (default)
2. English

Lalu menu aksi:

- `0` ganti bahasa
- `1` install panel Garuda Deck 1.15.2
- `2` cek VPS dan panel, tanpa ubah apa pun
- `3` backup saja, aman sebelum ubah
- `4` rollback ke snapshot backup lama, kode plus database
- `6` uninstall theme, kebalikan penuh install, kembali ke Pterodactyl default
- `5` keluar

Aksi langsung tetap bisa:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) id install
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) check
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) backup
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) rollback
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) uninstall
```

Panel beda path:

```bash
PANEL_DIR=/var/www/panel bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
```

Paksa bahasa tanpa menu:

```bash
GARUDADECK_LANG=id bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) install
GARUDADECK_LANG=en bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) install
```

Mode hemat info:

```bash
QUIET=1 bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
```

## Yang dilakukan installer

1. Cek cerdas: tipe VPS, arch, OS, panel 1.11 sampai 1.15, PHP 8.2 atau 8.3, `pdo_mysql`, `.env`, vendor, disk. Gagal berarti batal sebelum ubah apa pun.
2. Backup otomatis sebelum ubah. Gagal di tengah berarti rollback otomatis.
3. Bersihkan semua sisa tema lama sampai tuntas.
4. Pasang panel Garuda Deck 1.15.2 penuh, tanpa build manual.
5. Terapkan nama, judul, deskripsi, foto, dan ikon website Garuda Deck, migrasi, bersihkan cache, perbaiki hak akses.
6. Verifikasi akhir: nama, foto, ikon website, judul, deskripsi Garuda Deck, watermark login, watermark client, watermark admin.

## Yang dipertahankan

- Konfigurasi panel tujuan.
- Isi penyimpanan dan data panel.
- Pengaturan yang sudah ada tetap dipakai.

## Preview

Screenshot realtime dari VPS tujuan setelah 6 tahap lolos:

![login](../preview/panel/01-login.png)
![dashboard](../preview/panel/02-dashboard.png)
![account](../preview/panel/03-account.png)
![api](../preview/panel/04-api.png)
![ssh](../preview/panel/05-ssh.png)
![activity](../preview/panel/06-activity.png)
![admin overview](../preview/panel/07-admin-overview.png)
![admin settings](../preview/panel/08-admin-settings.png)
![admin users](../preview/panel/10-admin-users.png)
![admin servers](../preview/panel/11-admin-servers.png)
![admin nodes](../preview/panel/12-admin-nodes.png)
![admin nests](../preview/panel/13-admin-nests.png)
![admin databases](../preview/panel/14-admin-databases.png)
![admin locations](../preview/panel/15-admin-locations.png)
![admin mounts](../preview/panel/16-admin-mounts.png)

### Server GarudaCraft, Minecraft Paper

![console](../preview/server/console.png)
![files](../preview/server/files.png)
![file json](../preview/server/file-json.png)
![file sql](../preview/server/file-sql.png)
![databases](../preview/server/databases.png)
![startup egg](../preview/server/startup-egg.png)
![network](../preview/server/network.png)
![backups](../preview/server/backups.png)
![schedules](../preview/server/schedules.png)
![users](../preview/server/users.png)
![settings](../preview/server/settings.png)
![activity](../preview/server/activity.png)

Panduan lain di [docs/](../docs/): [INSTALL-ID.md](INSTALL-ID.md), [INSTALL-EN.md](INSTALL-EN.md), [COMPATIBILITY.md](COMPATIBILITY.md), [TROUBLESHOOTING.md](TROUBLESHOOTING.md).

## Syarat

- Default Ubuntu 20.04, 22.04, 24.04 atau Debian 11, 12. Mode cerdas memberi peringatan tapi lanjut di Linux lain selama panel dan PHP lolos.
- PHP 8.2 atau 8.3 dengan `pdo_mysql`.
- Panel 1.11 sampai 1.15.
- Root atau sudo, ruang disk minimal 300 MB.
- Node dan yarn tidak dibutuhkan di VPS tujuan.

## Backup, rollback, dan uninstall

Backup tersimpan otomatis sebelum install. Rollback manual lewat menu nomor 4. Matikan rollback otomatis dengan `AUTO_ROLLBACK=0`. Rollback mengembalikan snapshot backup lama berisi kode plus database. Uninstall lewat menu nomor 6 adalah kebalikan realtime dari install: copot semua file Garuda Deck sampai bersih, pasang ulang file stock Pterodactyl, buang tabel dan migrasi Garuda, kembalikan nama dan SEO ke default, data server dan user tetap aman, dan selalu buat backup pengaman dulu.

## Brand

Logo di [brand/](../brand/garudadeck-logo.png). Teks watermark di semua sisi: **Garuda Deck by verlangid from Indonesia**.

## Lisensi

MIT. Dibuat oleh **verlangid** dari Indonesia.
