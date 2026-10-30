#!/bin/bash
# GarudaDeck installer via GHCR public package, tanpa token, pola verlang docker.
# Repo garudadeck-theme tetap private, package ghcr.io public, repo dist hanya etalase promo.
# curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-dist/main/install.sh | bash
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
need python3
case "$ACTION" in install|check|backup|rollback) ;; *) fail "aksi tidak dikenal: $ACTION" ;; esac
ORAS_BIN="$TMP_DIR/oras"
ARCHIVE="$TMP_DIR/theme.tar.gz"
EXTRACT="$TMP_DIR/extract"
ORAS_VER="1.2.0"
ORAS_URL="https://github.com/oras-project/oras/releases/download/v${ORAS_VER}/oras_${ORAS_VER}_linux_amd64.tar.gz"
log "GarudaDeck via GHCR public, paket $PACKAGE:$TAG, panel $PANEL_DIR, aksi $ACTION"
mkdir -p "$EXTRACT"
if ! command -v oras >/dev/null 2>&1; then
  log "unduh oras sekali pakai"
  curl -fsSL "$ORAS_URL" -o "$TMP_DIR/oras.tar.gz" || fail "gagal unduh oras"
  tar -xzf "$TMP_DIR/oras.tar.gz" -C "$TMP_DIR" oras || fail "ekstrak oras gagal"
  chmod +x "$ORAS_BIN"
else
  ORAS_BIN="oras"
fi
log "tarik tema dari $PACKAGE:$TAG tanpa token"
"$ORAS_BIN" pull "$PACKAGE:$TAG" -o "$TMP_DIR" || fail "gagal pull $PACKAGE:$TAG, pastikan package sudah Public di GHCR"
FOUND="$(ls "$TMP_DIR"/*.tar.gz 2>/dev/null | head -1 || true)"
[ -n "$FOUND" ] || fail "tarball tidak ketemu di package $PACKAGE:$TAG"
cp "$FOUND" "$ARCHIVE"
tar -xzf "$ARCHIVE" -C "$EXTRACT" || fail "arsip rusak"
SWITCHER="$EXTRACT/theme-switcher"
[ -f "$SWITCHER/install.sh" ] || fail "install.sh tidak ketemu di paket"
log "jalankan $ACTION"
PANEL_DIR="$PANEL_DIR" bash "$SWITCHER/install.sh" "$ACTION"
