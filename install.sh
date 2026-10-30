#!/bin/bash
# GarudaDeck installer via GHCR docker image public, tanpa token, pola verlang docker.
# Repo garudadeck-dist tetap private, etalase ini garudadeck-theme, package ghcr.io public.
# curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh | bash
# Aksi: tambah -s -- check | backup | rollback
set -euo pipefail
if [ "$(id -u)" != "0" ]; then
  if command -v sudo >/dev/null 2>&1; then
    echo "[garudadeck] bukan root, naik ke sudo otomatis"
    exec sudo -E bash "$0" "$@"
  else
    echo "[garudadeck] ERROR: jalankan sebagai root atau install sudo dulu" >&2
    exit 1
  fi
fi
PACKAGE="${PACKAGE:-ghcr.io/verlangid11/garudadeck-theme}"
TAG="${GARUDADECK_TAG:-1.15.2}"
PANEL_DIR="${PANEL_DIR:-/var/www/pterodactyl}"
ACTION="${1:-install}"
TMP_DIR="$(mktemp -d)"
cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT
log() { echo "[garudadeck] $1"; }
fail() { echo "[garudadeck] ERROR: $1" >&2; exit 1; }
need() { command -v "$1" >/dev/null 2>&1 || fail "$1 belum terpasang, install dulu: apt install $1"; }
need curl
need tar
case "$ACTION" in install|check|backup|rollback) ;; *) fail "aksi tidak dikenal: $ACTION" ;; esac
OWNER_LC="$(echo "$PACKAGE" | cut -d/ -f2 | tr '[:upper:]' '[:lower:]')"
PKG_REAL="ghcr.io/${OWNER_LC}/garudadeck-theme:${TAG}"
ARCHIVE="$TMP_DIR/theme.tar.gz"
EXTRACT="$TMP_DIR/extract"
log "GarudaDeck via GHCR docker public, paket $PKG_REAL, panel $PANEL_DIR, aksi $ACTION"
mkdir -p "$EXTRACT"
if command -v docker >/dev/null 2>&1; then
  log "tarik via docker pull tanpa token"
  docker pull "$PKG_REAL" || fail "gagal pull $PKG_REAL, pastikan package sudah Public di GHCR"
  CID="$(docker create "$PKG_REAL")"
  docker cp "$CID:/theme.tar.gz" "$ARCHIVE" || fail "gagal salin dari image"
  docker rm "$CID" >/dev/null
else
  need python3
  log "docker tidak ada, tarik via API GHCR tanpa token"
  TOKEN="$(curl -fsSL "https://ghcr.io/token?service=ghcr.io&scope=repository:${OWNER_LC}/garudadeck-theme:pull" | python3 -c "import json,sys; print(json.load(sys.stdin).get('token',''))")"
  [ -n "$TOKEN" ] || fail "gagal minta token anonim GHCR"
  MANIFEST="$(curl -fsSL -H "Authorization: Bearer $TOKEN" -H "Accept: application/vnd.docker.distribution.manifest.v2+json" "https://ghcr.io/v2/${OWNER_LC}/garudadeck-theme/manifests/${TAG}")" || fail "manifest tidak ketemu"
  DIGEST="$(echo "$MANIFEST" | python3 -c "import json,sys; d=json.load(sys.stdin); ls=d.get('layers',[]); print(ls[0]['digest'] if ls else '')")"
  [ -n "$DIGEST" ] || fail "layer tidak ketemu"
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
