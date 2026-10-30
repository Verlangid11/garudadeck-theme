#!/bin/bash
# GarudaDeck public installer by verlangid from Indonesia, MIT.
# Source repo private, package dist public, no token needed.
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
DIST_REPO="${DIST_REPO:-Verlangid11/garudadeck-dist}"
DIST_BRANCH="${DIST_BRANCH:-main}"
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
TARBALL_URL="https://github.com/${DIST_REPO}/releases/latest/download/garudadeck-theme-1.15.2.tar.gz"
RAW_URL="https://raw.githubusercontent.com/${DIST_REPO}/${DIST_BRANCH}/install.sh"
ARCHIVE="$TMP_DIR/theme.tar.gz"
EXTRACT="$TMP_DIR/extract"
log "GarudaDeck public dist, repo $DIST_REPO, panel $PANEL_DIR, aksi $ACTION"
mkdir -p "$EXTRACT"
if ! curl -fsSL "$TARBALL_URL" -o "$ARCHIVE"; then
  fail "gagal unduh $TARBALL_URL, cek rilis di https://github.com/${DIST_REPO}/releases"
fi
tar -xzf "$ARCHIVE" -C "$EXTRACT" || fail "arsip rusak"
SWITCHER="$EXTRACT/theme-switcher"
[ -f "$SWITCHER/install.sh" ] || fail "install.sh tidak ketemu di paket"
log "jalankan $ACTION"
PANEL_DIR="$PANEL_DIR" bash "$SWITCHER/install.sh" "$ACTION"
