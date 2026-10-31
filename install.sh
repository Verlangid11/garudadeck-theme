#!/bin/bash
# GarudaDeck installer via GHCR docker image public, tanpa token, pola verlang docker.
# Repo garudadeck-dist tetap private, etalase ini garudadeck-theme, package ghcr.io public.
# Satu command: bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
# Menu angka: 1 install, 2 check, 3 backup, 4 rollback, 5 keluar. Argumen langsung tetap bisa: check, backup, install, rollback.
set -euo pipefail
SELF_URL="https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh"
if [ "$(id -u)" != "0" ]; then
  if command -v sudo >/dev/null 2>&1; then
    if [ -f "${0:-}" ] && [ "${0:-bash}" != "bash" ] && [ "$0" != "-bash" ] && [ "$0" != "/dev/fd/63" ] && [[ "$0" != /dev/fd/* ]]; then
      exec sudo -E bash "$0" "$@"
    else
      TMP_SELF="$(mktemp /tmp/garudadeck-install.XXXXXX)"
      curl -fsSL "$SELF_URL" -o "$TMP_SELF"
      chmod +x "$TMP_SELF"
      exec sudo -E bash "$TMP_SELF" "$@"
    fi
  else
    echo "ERROR: jalankan sebagai root atau install sudo dulu, contoh: apt install sudo -y" >&2
    exit 1
  fi
fi
if [ -t 0 ] && [ $# -eq 0 ]; then
  :
elif [ $# -eq 0 ]; then
  set -- install
fi
C_RESET="\033[0m"; C_RED="\033[1;31m"; C_GREEN="\033[1;32m"; C_YELLOW="\033[1;33m"; C_BLUE="\033[1;34m"; C_MAGENTA="\033[1;35m"; C_CYAN="\033[1;36m"; C_WHITE="\033[1;37m"; C_DIM="\033[2m"
say() { printf "%b%s%b\n" "$1" "$2" "$C_RESET"; }
banner() {
  clear 2>/dev/null || true
  say "$C_RED" "   ____                   _       ____            _"
  say "$C_RED" "  / ___| __ _ _ __ _   _| | __ _|  _ \\\\  ___  ___| | __"
  say "$C_YELLOW" " | |  _ / _\` | '__| | | | |/ _\` | | | |/ _ \\\\/ __| |/ /"
  say "$C_YELLOW" " | |_| | (_| | |  | |_| | | (_| | |_| |  __/ (__|   <"
  say "$C_GREEN" "  \\\\____|\\\\__,_|_|   \\\\__,_|_|\\\\__,_|____/ \\\\___|\\\\___|_|\\\\_\\\\"
  say "$C_CYAN" "  GarudaDeck Installer, panel Garuda Deck 1.15.2, MIT"
  echo ""
}
menu() {
  banner
  say "$C_WHITE" "  Mau ngapain hari ini bro?"
  say "$C_GREEN" "  [1] Install panel Garuda Deck 1.15.2"
  say "$C_BLUE" "  [2] Cek VPS dan panel, tanpa ubah apa pun"
  say "$C_YELLOW" "  [3] Backup saja, aman sebelum ubah"
  say "$C_MAGENTA" "  [4] Rollback ke backup terakhir"
  say "$C_RED" "  [5] Keluar"
  echo ""
  say "$C_DIM" "  Install 1 sampai 3 menit, aset sudah ikut paket."
  printf "%b" "$C_CYAN"
  read -r -p "  Pilih [1-5] (default 1): " PICK
  printf "%b" "$C_RESET"
  PICK="${PICK:-1}"
  case "$PICK" in
    1) ACTION="install" ;; 2) ACTION="check" ;; 3) ACTION="backup" ;; 4) ACTION="rollback" ;; 5) say "$C_GREEN" "  Siap, sampai jumpa bro"; exit 0 ;; *) say "$C_RED" "  Pilihan tidak dikenal, jalanin install"; ACTION="install" ;;
  esac
}
spin_pull() {
  local msg="$1"; shift
  local frames="⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏"
  printf "%b" "$C_CYAN" >&2
  "$@" >"$TMP_DIR/pull.log" 2>&1 &
  local pid=$!
  local i=0
  while kill -0 $pid 2>/dev/null; do
    i=$(( (i + 1) % 10 ))
    local f
    f=$(echo "$frames" | cut -d' ' -f$((i + 1)))
    printf "\r  %s %s" "$f" "$msg" >&2
    sleep 0.12
  done
  wait $pid
  local code=$?
  printf "\r%b" "$C_RESET" >&2
  if [ $code -ne 0 ]; then
    echo "cek koneksi lalu coba lagi" >&2
    return $code
  fi
  say "$C_GREEN" "  done: $msg"
  return 0
}
PACKAGE="${PACKAGE:-ghcr.io/verlangid11/garudadeck-theme}"
TAG="${GARUDADECK_TAG:-latest}"
PANEL_DIR="${PANEL_DIR:-/var/www/pterodactyl}"
ACTION=""
if [ $# -gt 0 ]; then
  case "${1:-}" in install|check|backup|rollback) ACTION="$1" ;; *) ACTION="" ;; esac
fi
if [ -z "$ACTION" ]; then
  if [ -t 0 ]; then
    menu
  elif [ -r /dev/tty ]; then
    menu </dev/tty
  else
    ACTION="install"
  fi
fi
TMP_DIR="$(mktemp -d)"
cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT
log() { say "$C_CYAN" "[garudadeck] $1"; }
ok() { say "$C_GREEN" "[garudadeck] $1"; }
warn() { say "$C_YELLOW" "[garudadeck] $1"; }
fail() { say "$C_RED" "[garudadeck] ERROR: $1"; exit 1; }
need() { command -v "$1" >/dev/null 2>&1 || fail "$1 belum terpasang, install dulu: apt install $1 -y"; }
find_panel() {
  if [ -f "$1/config/app.php" ] && [ -f "$1/artisan" ]; then echo "$1"; return 0; fi
  return 1
}
if [ -t 0 ] && [ "$ACTION" = "install" ]; then banner; fi
say "$C_WHITE" "  Halo bro, GarudaDeck siap jalan, aksi $ACTION."
if ! find_panel "$PANEL_DIR" >/dev/null 2>&1; then
  warn "panel tidak ketemu di lokasi default, cari otomatis dulu"
  FOUND=""
  for d in /var/www/pterodactyl /var/www/panel /var/www/ptero /srv/pterodactyl /opt/pterodactyl /var/www/html; do
    if find_panel "$d" >/dev/null 2>&1; then FOUND="$d"; break; fi
  done
  if [ -z "$FOUND" ] && [ -d /var/www ]; then
    CAND="$(find /var/www -maxdepth 4 -name artisan -type f 2>/dev/null | head -1 || true)"
    if [ -n "$CAND" ]; then
      CAND_DIR="$(dirname "$CAND")"
      if find_panel "$CAND_DIR" >/dev/null 2>&1; then FOUND="$CAND"; fi
    fi
  fi
  if [ -n "$FOUND" ]; then
    ok "panel ketemu, lanjut $ACTION"
    PANEL_DIR="$FOUND"
  else
    fail "panel tidak ketemu. Install panel dulu atau set PANEL_DIR manual"
  fi
fi
ok "panel ketemu, lanjut $ACTION"
need curl
need tar
case "$ACTION" in install|check|backup|rollback) ;; *) fail "aksi tidak dikenal: $ACTION, pilih: install, check, backup, rollback" ;; esac
OWNER_LC="$(echo "$PACKAGE" | cut -d/ -f2 | tr '[:upper:]' '[:lower:]')"
PKG_REAL="ghcr.io/${OWNER_LC}/garudadeck-theme:${TAG}"
ARCHIVE="$TMP_DIR/theme.tar.gz"
EXTRACT="$TMP_DIR/extract"
log "paket siap, aksi $ACTION"
mkdir -p "$EXTRACT"
if command -v docker >/dev/null 2>&1 && [ "${GARUDADECK_FORCE_API:-0}" != "1" ]; then
  spin_pull "siapkan paket installer" docker pull "$PKG_REAL" >/dev/null 2>&1 || fail "gagal siapkan paket, cek koneksi"
  CID="$(docker create "$PKG_REAL")"
  docker cp "$CID:/theme.tar.gz" "$ARCHIVE" || fail "gagal salin dari image"
  docker rm "$CID" >/dev/null
  ok "paket ketarik, lanjut $ACTION"
else
  need python3
  log "siapkan paket installer"
  TOKEN="$(curl -fsSL "https://ghcr.io/token?service=ghcr.io&scope=repository:${OWNER_LC}/garudadeck-theme:pull" | python3 -c "import json,sys; print(json.load(sys.stdin).get('token',''))")"
  [ -n "$TOKEN" ] || fail "gagal siapkan unduhan, cek koneksi"
  ACCEPT="application/vnd.oci.image.index.v1+json, application/vnd.docker.distribution.manifest.list.v2+json, application/vnd.oci.image.manifest.v1+json, application/vnd.docker.distribution.manifest.v2+json"
  MANIFEST="$(curl -fsSL -H "Authorization: Bearer $TOKEN" -H "Accept: $ACCEPT" "https://ghcr.io/v2/${OWNER_LC}/garudadeck-theme/manifests/${TAG}")" || fail "paket tidak ketemu, coba lagi nanti"
  case "$(uname -m)" in
    x86_64) PLAT="amd64" ;;
    aarch64|arm64) PLAT="arm64" ;;
    *) PLAT="$(uname -m)" ;;
  esac
  MDIGEST="$(echo "$MANIFEST" | PLAT="$PLAT" python3 -c "import json,sys,os; d=json.load(sys.stdin); p=os.environ['PLAT']; print(next((m['digest'] for m in d.get('manifests',[]) if m.get('platform',{}).get('os')=='linux' and m.get('platform',{}).get('architecture')==p), ''))")"
  if [ -n "$MDIGEST" ]; then
    MANIFEST="$(curl -fsSL -H "Authorization: Bearer $TOKEN" -H "Accept: $ACCEPT" "https://ghcr.io/v2/${OWNER_LC}/garudadeck-theme/manifests/${MDIGEST}")" || fail "paket tidak cocok untuk mesin ini"
  fi
  DIGEST="$(echo "$MANIFEST" | python3 -c "import json,sys; d=json.load(sys.stdin); ls=d.get('layers',[]); print(ls[-1]['digest'] if ls else '')")"
  [ -n "$DIGEST" ] || fail "paket tidak lengkap, coba lagi nanti"
  spin_pull "siapkan paket installer" curl -fsSL -H "Authorization: Bearer $TOKEN" "https://ghcr.io/v2/${OWNER_LC}/garudadeck-theme/blobs/$DIGEST" -o "$TMP_DIR/layer.tar" >/dev/null 2>&1 || fail "gagal siapkan paket, cek koneksi"
  LAYERTMP="$(mktemp -d)"
  tar -xzf "$TMP_DIR/layer.tar" -C "$LAYERTMP" || fail "ekstrak layer gagal"
  FOUND_LAYER="$(find "$LAYERTMP" -name "theme.tar.gz" | head -1)"
  [ -n "$FOUND_LAYER" ] || fail "theme.tar.gz tidak ada di image"
  cp "$FOUND_LAYER" "$ARCHIVE"
fi
tar -xzf "$ARCHIVE" -C "$EXTRACT" || fail "arsip rusak"
SWITCHER="$EXTRACT/theme-switcher"
[ -f "$SWITCHER/install.sh" ] || fail "install.sh tidak ketemu di paket"
log "paket siap, jalanin $ACTION sekarang"
PANEL_DIR="$PANEL_DIR" bash "$SWITCHER/install.sh" "$ACTION"
