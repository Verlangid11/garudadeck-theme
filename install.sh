#!/bin/bash
# GarudaDeck installer via GHCR docker image public, tanpa token, pola verlang docker.
# Repo garudadeck-dist tetap private, etalase ini garudadeck-theme, package ghcr.io public.
# Pakai satu command: bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
# Aksi: bash <(curl -fsSL ...) check | backup | install | rollback, atau PANEL_DIR=/path bash <(curl ...)
set -euo pipefail
SELF_URL="https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh"
if [ "$(id -u)" != "0" ]; then
  if command -v sudo >/dev/null 2>&1; then
    echo "[garudadeck] bukan root, naik ke sudo otomatis"
    if [ -f "${0:-}" ] && [ "${0:-bash}" != "bash" ] && [ "$0" != "-bash" ] && [ "$0" != "/dev/fd/63" ] && [[ "$0" != /dev/fd/* ]]; then
      exec sudo -E bash "$0" "$@"
    else
      TMP_SELF="$(mktemp /tmp/garudadeck-install.XXXXXX)"
      curl -fsSL "$SELF_URL" -o "$TMP_SELF"
      chmod +x "$TMP_SELF"
      exec sudo -E bash "$TMP_SELF" "$@"
    fi
  else
    echo "[garudadeck] ERROR: jalankan sebagai root atau install sudo dulu, contoh: apt install sudo -y" >&2
    exit 1
  fi
fi
PACKAGE="${PACKAGE:-ghcr.io/verlangid11/garudadeck-theme}"
TAG="${GARUDADECK_TAG:-latest}"
PANEL_DIR="${PANEL_DIR:-/var/www/pterodactyl}"
ACTION="${1:-install}"
TMP_DIR="$(mktemp -d)"
cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT
log() { echo "[garudadeck] $1"; }
fail() { echo "[garudadeck] ERROR: $1" >&2; exit 1; }
need() { command -v "$1" >/dev/null 2>&1 || fail "$1 belum terpasang, install dulu: apt install $1 -y"; }
find_panel() {
  if [ -f "$1/config/app.php" ] && [ -f "$1/artisan" ]; then echo "$1"; return 0; fi
  return 1
}
if ! find_panel "$PANEL_DIR" >/dev/null 2>&1; then
  log "panel tidak ketemu di $PANEL_DIR, cari otomatis"
  FOUND=""
  for d in /var/www/pterodactyl /var/www/panel /var/www/ptero /srv/pterodactyl /opt/pterodactyl /var/www/html; do
    if find_panel "$d" >/dev/null 2>&1; then FOUND="$d"; break; fi
  done
  if [ -z "$FOUND" ] && [ -d /var/www ]; then
    CAND="$(find /var/www -maxdepth 4 -name artisan -type f 2>/dev/null | head -1 || true)"
    if [ -n "$CAND" ]; then
      CAND_DIR="$(dirname "$CAND")"
      if find_panel "$CAND_DIR" >/dev/null 2>&1; then FOUND="$CAND_DIR"; fi
    fi
  fi
  if [ -n "$FOUND" ]; then
    log "ketemu panel di $FOUND, pakai itu"
    PANEL_DIR="$FOUND"
  else
    echo "[garudadeck] ERROR: panel Pterodactyl tidak ketemu di VPS ini" >&2
    echo "[garudadeck] ciri: tidak ada artisan dan config/app.php di /var/www" >&2
    echo "[garudadeck] solusi: install panel dulu, atau tentukan manual:" >&2
    echo "[garudadeck] PANEL_DIR=/path/panel bash <(curl -fsSL $SELF_URL)" >&2
    echo "[garudadeck] contoh: sudo PANEL_DIR=/var/www/pterodactyl bash <(curl -fsSL $SELF_URL) check" >&2
    exit 1
  fi
fi
log "panel ketemu di $PANEL_DIR"
need curl
need tar
case "$ACTION" in install|check|backup|rollback) ;; *) fail "aksi tidak dikenal: $ACTION, pilih: install, check, backup, rollback" ;; esac
OWNER_LC="$(echo "$PACKAGE" | cut -d/ -f2 | tr '[:upper:]' '[:lower:]')"
PKG_REAL="ghcr.io/${OWNER_LC}/garudadeck-theme:${TAG}"
ARCHIVE="$TMP_DIR/theme.tar.gz"
EXTRACT="$TMP_DIR/extract"
log "GarudaDeck via GHCR docker public, paket $PKG_REAL, panel $PANEL_DIR, aksi $ACTION"
mkdir -p "$EXTRACT"
if command -v docker >/dev/null 2>&1; then
  log "tarik via docker pull tanpa token"
  docker pull "$PKG_REAL" || fail "gagal pull $PKG_REAL, cek koneksi atau coba GARUDADECK_TAG=latest"
  CID="$(docker create "$PKG_REAL")"
  docker cp "$CID:/theme.tar.gz" "$ARCHIVE" || fail "gagal salin dari image"
  docker rm "$CID" >/dev/null
else
  need python3
  log "docker tidak ada, tarik via API GHCR tanpa token"
  TOKEN="$(curl -fsSL "https://ghcr.io/token?service=ghcr.io&scope=repository:${OWNER_LC}/garudadeck-theme:pull" | python3 -c "import json,sys; print(json.load(sys.stdin).get('token',''))")"
  [ -n "$TOKEN" ] || fail "gagal minta token anonim GHCR, cek koneksi"
  MANIFEST="$(curl -fsSL -H "Authorization: Bearer $TOKEN" -H "Accept: application/vnd.docker.distribution.manifest.v2+json" "https://ghcr.io/v2/${OWNER_LC}/garudadeck-theme/manifests/${TAG}")" || fail "manifest $TAG tidak ketemu, coba GARUDADECK_TAG=latest"
  DIGEST="$(echo "$MANIFEST" | python3 -c "import json,sys; d=json.load(sys.stdin); ls=d.get('layers',[]); print(ls[-1]['digest'] if ls else '')")"
  [ -n "$DIGEST" ] || fail "layer tidak ketemu di $TAG"
  curl -fsSL -H "Authorization: Bearer $TOKEN" "https://ghcr.io/v2/${OWNER_LC}/garudadeck-theme/blobs/$DIGEST" -o /tmp/layer.tar || fail "unduh layer gagal"
  tar -xzf /tmp/layer.tar -C "$TMP_DIR" || fail "ekstrak layer gagal"
  FOUND_LAYER="$(find "$TMP_DIR" -name "theme.tar.gz" | head -1)"
  [ -n "$FOUND_LAYER" ] || fail "theme.tar.gz tidak ada di image"
  cp "$FOUND_LAYER" "$ARCHIVE"
fi
tar -xzf "$ARCHIVE" -C "$EXTRACT" || fail "arsip rusak"
SWITCHER="$EXTRACT/theme-switcher"
[ -f "$SWITCHER/install.sh" ] || fail "install.sh tidak ketemu di paket"
log "jalankan $ACTION"
PANEL_DIR="$PANEL_DIR" bash "$SWITCHER/install.sh" "$ACTION"
