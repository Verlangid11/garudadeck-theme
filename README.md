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

<p align="center"><b>Installer panel Garuda Deck 1.15.2.</b></p>

Installer satu perintah untuk memasang panel **Garuda Deck 1.15.2 penuh**. Nama installer tetap **GarudaDeck**, lisensi MIT.

Hasil akhir: login berfoto Garuda Deck, nama tampil **Garuda Deck** di semua tampilan.

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

Mode hemat info:

```bash
QUIET=1 bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
```

## Yang dilakukan installer

1. Cek kompatibilitas VPS dan panel. Gagal berarti batal sebelum ubah apa pun.
2. Backup otomatis sebelum ubah. Gagal di tengah berarti rollback otomatis.
3. Bersihkan sisa tema lama sampai tuntas.
4. Pasang panel Garuda Deck 1.15.2 penuh, tanpa build manual.
5. Terapkan nama Garuda Deck dan rapikan cache serta hak akses.
6. Verifikasi hasil akhir sampai nama Garuda Deck aktif.

## Yang dipertahankan

- Konfigurasi panel tujuan.
- Isi penyimpanan dan data panel.
- Pengaturan yang sudah ada tetap dipakai.

## Preview Garuda Deck

Tampilan realtime dari VPS tujuan setelah install 6 tahap lolos:

![login](preview/01-login.png)
![dashboard](preview/02-dashboard.png)
![account](preview/03-account.png)
![api](preview/04-api.png)
![ssh](preview/05-ssh.png)
![activity](preview/06-activity.png)
![admin overview](preview/07-admin-overview.png)
![admin settings](preview/08-admin-settings.png)
![admin users](preview/10-admin-users.png)
![admin servers](preview/11-admin-servers.png)
![admin nodes](preview/12-admin-nodes.png)
![admin nests](preview/13-admin-nests.png)
![admin databases](preview/14-admin-databases.png)
![admin locations](preview/15-admin-locations.png)
![admin mounts](preview/16-admin-mounts.png)

## Syarat

- Ubuntu 20.04, 22.04, 24.04 atau Debian 11, 12.
- PHP 8.2 atau 8.3 dengan `pdo_mysql`.
- Panel 1.11 sampai 1.15.
- Root atau sudo, ruang disk minimal 300 MB.
- Node dan yarn tidak dibutuhkan di VPS tujuan.

## Backup dan rollback

Backup tersimpan otomatis sebelum install. Rollback manual lewat menu nomor 4. Matikan rollback otomatis dengan `AUTO_ROLLBACK=0`.

## Lisensi

MIT. Dibuat oleh **verlangid** dari Indonesia.
