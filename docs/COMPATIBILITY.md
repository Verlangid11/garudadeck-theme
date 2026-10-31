# Compatibility / Kompatibilitas

EN first, ID follows.

## Default supported

EN:

- OS default: Ubuntu 20.04, 22.04, 24.04, Debian 11, 12.
- PHP: 8.2, 8.3 with `pdo_mysql`.
- Panel: 1.11.0 to 1.15.99, full install target 1.15.2.
- Arch: x86_64 and arm64 fast path via GHCR multi-arch logic, other arch falls back to API blob pull.
- VPS: KVM, bare metal, LXC, OpenVZ, Docker, cloud images. Installer prints detected virt and arch first.
- Disk: at least 300 MB free.
- Privilege: root or sudo.
- Node and yarn: not needed on target VPS.

ID:

- OS default: Ubuntu 20.04, 22.04, 24.04, Debian 11, 12.
- PHP: 8.2, 8.3 dengan `pdo_mysql`.
- Panel: 1.11.0 sampai 1.15.99, target install penuh 1.15.2.
- Arch: x86_64 dan arm64 jalur cepat via logika multi-arch GHCR, arch lain fallback lewat API blob pull.
- VPS: KVM, bare metal, LXC, OpenVZ, Docker, image cloud. Installer menampilkan virt dan arch dulu.
- Disk: minimal 300 MB bebas.
- Hak akses: root atau sudo.
- Node dan yarn: tidak dibutuhkan di VPS tujuan.

## Smart extended mode

EN: other or unknown Linux gets a warning, not a hard abort. Install continues when panel files, panel version, PHP version, `pdo_mysql`, `.env`, vendor, and disk all pass. This keeps support wide for all VPS types and compatible OS families.

ID: Linux lain atau tidak dikenal hanya peringatan, bukan batal keras. Install lanjut selama file panel, versi panel, versi PHP, `pdo_mysql`, `.env`, vendor, dan disk semua lolos. Ini menjaga dukungan luas untuk semua jenis VPS dan keluarga OS kompatibel.

## Panel search

EN: default `/var/www/pterodactyl`, then common paths, then automatic up to 4 level search under `/var/www`, `/srv`, `/opt`, `/home`.

ID: default `/var/www/pterodactyl`, lalu path umum, lalu cari otomatis sampai 4 level di bawah `/var/www`, `/srv`, `/opt`, `/home`.
