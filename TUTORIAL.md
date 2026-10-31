# Tutorial GarudaDeck Installer

Installer satu perintah untuk memasang panel **Garuda Deck 1.15.2**.

## 1. Masuk VPS

```bash
ssh user@ip-vps-kamu
```

## 2. Cek kompatibilitas

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) check
```

Tidak mengubah apa pun. Bila gagal, perbaiki pesan yang muncul lalu ulangi.

## 3. Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
```

Pilih nomor 1.

## 4. Buka panel

Refresh browser. Login berfoto Garuda Deck dan bernama **Garuda Deck**.

## 5. Bila error

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh) rollback
```

Atau pilih menu nomor 4.
