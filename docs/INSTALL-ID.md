# Panduan Install ID

## 1. Masuk VPS

```bash
ssh user@ip-vps-kamu
```

## 2. Cek kompatibilitas

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) id check
```

Tidak mengubah apa pun. Bila gagal, perbaiki pesan yang muncul lalu ulangi.

Perilaku cerdas:

- Deteksi virtualisasi VPS dan arch, ditampilkan sebelum cek.
- Default OS: Ubuntu 20.04, 22.04, 24.04, Debian 11, 12.
- Linux lain atau tidak dikenal: hanya peringatan, lanjut selama panel 1.11 sampai 1.15 dan PHP 8.2 atau 8.3 lolos.
- Cari panel otomatis di path umum plus sampai 4 level di bawah `/var/www`, `/srv`, `/opt`, `/home`.

## 3. Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
```

Pilih bahasa dulu, lalu nomor 1.

Paksa Indonesia tanpa menu:

```bash
GARUDADECK_LANG=id bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) install
```

## 4. Buka panel

Refresh browser. Login berfoto Garuda Deck dan bernama **Garuda Deck**, watermark **Garuda Deck by verlangid from Indonesia**.

## 5. Bila error

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) rollback
```

Atau pilih menu nomor 4. Rollback mengembalikan snapshot lama berisi kode plus database.

## 6. Uninstall theme, data aman

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) uninstall
```

Atau pilih menu nomor 6. Uninstall hanya melepas branding dan watermark, mengembalikan nama dan ikon stock, data server, user, database, pengumuman, dan custom domain saat ini tetap dipakai, backup pengaman dibuat dulu.

## Catatan

- `.env`, storage, dan database panel tujuan dipertahankan, kecuali nama panel diset ke Garuda Deck.
- Backup tersimpan aman, rollback tersedia.
- Tanpa token, paket dari GHCR public.
