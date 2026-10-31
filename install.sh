#!/bin/bash
# GarudaDeck smart wrapper, bilingual ID EN, public via GHCR without token.
# One command: bash <(curl -fsSL https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh)
# Menu numbers: 0 language, 1 install, 2 check, 3 backup, 4 rollback, 6 uninstall, 5 exit. Direct args still work.
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
    echo "ERROR: run as root or install sudo first / jalankan sebagai root atau install sudo dulu, example: apt install sudo -y" >&2
    exit 1
  fi
fi
GD_LANG="${GARUDADECK_LANG:-${GD_LANG:-}}"
ACTION_IN="${1:-}"
if [ -z "$GD_LANG" ]; then
  case "${ACTION_IN:-}" in
    id|ID|indonesia|Indonesian) GD_LANG="id"; shift || true ;;
    en|EN|english|English) GD_LANG="en"; shift || true ;;
  esac
fi
if [ $# -eq 0 ] && [ -t 0 ]; then
  :
elif [ $# -eq 0 ]; then
  GD_LANG="${GD_LANG:-id}"
  set -- install
fi
C_RESET="\033[0m"; C_RED="\033[1;31m"; C_GREEN="\033[1;32m"; C_YELLOW="\033[1;33m"; C_BLUE="\033[1;34m"; C_MAGENTA="\033[1;35m"; C_CYAN="\033[1;36m"; C_WHITE="\033[1;37m"; C_DIM="\033[2m"
say() { printf "%b%s%b\n" "$1" "$2" "$C_RESET"; }
L_EN=0
is_en() { [ "$GD_LANG" = "en" ]; }
T() { if is_en; then printf "%s" "$2"; else printf "%s" "$1"; fi; }
banner() {
  clear 2>/dev/null || true
  say "$C_RED" "   ____                   _       ____            _"
  say "$C_RED" "  / ___| __ _ _ __ _   _| | __ _|  _ \\\\  ___  ___| | __"
  say "$C_YELLOW" " | |  _ / _\` | '__| | | | |/ _\` | | | |/ _ \\\\/ __| |/ /"
  say "$C_YELLOW" " | |_| | (_| | |  | |_| | | (_| | |_| |  __/ (__|   <"
  say "$C_GREEN" "  \\\\____|\\\\__,_|_|   \\\\__,_|_|\\\\__,_|____/ \\\\___|\\\\___|_|\\\\_\\\\"
  say "$C_CYAN" "  GarudaDeck Installer, Garuda Deck panel 1.15.2, MIT"
  say "$C_DIM" "  Garuda Deck by verlangid from Indonesia"
  echo ""
}
lang_menu() {
  banner
  say "$C_WHITE" "  Choose language / Pilih bahasa:"
  say "$C_GREEN" "  [1] Indonesia (default)"
  say "$C_BLUE" "  [2] English"
  echo ""
  printf "%b" "$C_CYAN"
  read -r -p "  Language / Bahasa [1-2] (default 1): " LANG_PICK
  printf "%b" "$C_RESET"
  LANG_PICK="${LANG_PICK:-1}"
  case "$LANG_PICK" in
    2|en|EN|english|English) GD_LANG="en" ;; *) GD_LANG="id" ;;
  esac
  export GARUDADECK_LANG="$GD_LANG"
  export GD_LANG="$GD_LANG"
}
menu() {
  banner
  if is_en; then
    say "$C_WHITE" "  What do you want to do?"
    say "$C_GREEN" "  [1] Install Garuda Deck panel 1.15.2"
    say "$C_BLUE" "  [2] Check VPS and panel, change nothing"
    say "$C_YELLOW" "  [3] Backup only, safe before changes"
    say "$C_MAGENTA" "  [4] Rollback to latest backup"
    say "$C_RED" "  [6] Uninstall theme, keep servers and data"
    say "$C_CYAN" "  [0] Switch language (now: English)"
    say "$C_RED" "  [5] Exit"
  else
    say "$C_WHITE" "  Mau ngapain hari ini bro?"
    say "$C_GREEN" "  [1] Install panel Garuda Deck 1.15.2"
    say "$C_BLUE" "  [2] Cek VPS dan panel, tanpa ubah apa pun"
    say "$C_YELLOW" "  [3] Backup saja, aman sebelum ubah"
    say "$C_MAGENTA" "  [4] Rollback ke backup terakhir"
    say "$C_RED" "  [6] Uninstall theme, server dan data aman"
    say "$C_CYAN" "  [0] Ganti bahasa (saat ini: Indonesia)"
    say "$C_RED" "  [5] Keluar"
  fi
  echo ""
  say "$C_DIM" "  $(T "Install 1 sampai 3 menit, aset sudah ikut paket. Uninstall hanya lepas branding, rollback kembalikan snapshot lama." "Install takes 1 to 3 minutes, assets included. Uninstall only strips branding, rollback restores old snapshot.")"
  printf "%b" "$C_CYAN"
  read -r -p "  $(T "Pilih [0-6] (default 1): " "Choose [0-6] (default 1): ")" PICK
  printf "%b" "$C_RESET"
  PICK="${PICK:-1}"
  case "$PICK" in
    1) ACTION="install" ;; 2) ACTION="check" ;; 3) ACTION="backup" ;; 4) ACTION="rollback" ;; 6) ACTION="uninstall" ;;
    0) lang_menu; menu; return 0 ;;
    5) say "$C_GREEN" "  $(T "Siap, sampai jumpa bro" "Done, see you soon")"; exit 0 ;;
    *) say "$C_RED" "  $(T "Pilihan tidak dikenal, jalanin install" "Unknown choice, running install")"; ACTION="install" ;;
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
    echo "$(T "cek koneksi lalu coba lagi" "check connection then retry")" >&2
    return $code
  fi
  say "$C_GREEN" "  done: $msg"
  return 0
}
PACKAGE="${PACKAGE:-ghcr.io/verlangid11/garudadeck-theme}"
TAG="${GARUDADECK_TAG:-latest}"
PANEL_DIR="${PANEL_DIR:-/var/www/pterodactyl}"
ACTION=""
RAW_ARGS=("$@")
if [ $# -gt 0 ]; then
  case "${1:-}" in install|check|backup|rollback|uninstall) ACTION="$1"; shift || true ;; *) ACTION="" ;; esac
fi
if [ -z "$GD_LANG" ]; then
  if [ -t 0 ] || [ -r /dev/tty ]; then
    if [ -t 0 ]; then lang_menu; else lang_menu </dev/tty; fi
  elif [ "${GARUDADECK_LANG:-}" != "" ] || [ "${GD_LANG:-}" != "" ]; then
    GD_LANG="${GARUDADECK_LANG:-$GD_LANG}"
  else
    GD_LANG="id"
  fi
fi
GD_LANG="${GD_LANG:-id}"
export GARUDADECK_LANG="$GD_LANG"
export GD_LANG="$GD_LANG"
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
need() { command -v "$1" >/dev/null 2>&1 || fail "$1 $(T "belum terpasang, install dulu: apt install $1 -y" "missing, install first: apt install $1 -y")"; }
find_panel() {
  if [ -f "$1/config/app.php" ] && [ -f "$1/artisan" ]; then echo "$1"; return 0; fi
  return 1
}
detect_virt_fast() {
  if command -v systemd-detect-virt >/dev/null 2>&1; then systemd-detect-virt 2>/dev/null || echo bare; return 0; fi
  if [ -f /.dockerenv ]; then echo docker; return 0; fi
  echo unknown
}
VIRT_FAST="$(detect_virt_fast || echo unknown)"
ARCH_FAST="$(uname -m 2>/dev/null || echo unknown)"
if [ -t 0 ] && [ "$ACTION" = "install" ]; then banner; fi
say "$C_WHITE" "  $(T "Halo bro, GarudaDeck siap jalan, aksi $ACTION." "Hello, GarudaDeck ready, action $ACTION.")"
say "$C_DIM" "  VPS $VIRT_FAST arch $ARCH_FAST lang $GD_LANG"
if ! find_panel "$PANEL_DIR" >/dev/null 2>&1; then
  warn "$(T "panel tidak ketemu di lokasi default, cari otomatis dulu" "panel not found at default path, auto searching")"
  FOUND=""
  for d in /var/www/pterodactyl /var/www/panel /var/www/ptero /srv/pterodactyl /opt/pterodactyl /var/www/html /home/pterodactyl /home/panel; do
    if find_panel "$d" >/dev/null 2>&1; then FOUND="$d"; break; fi
  done
  if [ -z "$FOUND" ]; then
    for root in /var/www /srv /opt /home; do
      [ -d "$root" ] || continue
      CAND="$(find "$root" -maxdepth 4 -name artisan -type f 2>/dev/null | head -1 || true)"
      if [ -n "$CAND" ]; then
        CAND_DIR="$(dirname "$CAND")"
        if find_panel "$CAND_DIR" >/dev/null 2>&1; then FOUND="$CAND_DIR"; break; fi
      fi
    done
  fi
  if [ -n "$FOUND" ]; then
    ok "$(T "panel ketemu, lanjut $ACTION" "panel found, continue $ACTION")"
    PANEL_DIR="$FOUND"
  else
    fail "$(T "panel tidak ketemu. Install panel dulu atau set PANEL_DIR manual" "panel not found. Install panel first or set PANEL_DIR manually")"
  fi
fi
ok "$(T "panel ketemu, lanjut $ACTION" "panel found, continue $ACTION")"
need curl
need tar
case "$ACTION" in install|check|backup|rollback|uninstall) ;; *) fail "$(T "aksi tidak dikenal: $ACTION, pilih: install, check, backup, rollback, uninstall" "unknown action: $ACTION, choose: install, check, backup, rollback, uninstall")" ;; esac
OWNER_LC="$(echo "$PACKAGE" | cut -d/ -f2 | tr '[:upper:]' '[:lower:]')"
PKG_REAL="ghcr.io/${OWNER_LC}/garudadeck-theme:${TAG}"
ARCHIVE="$TMP_DIR/theme.tar.gz"
EXTRACT="$TMP_DIR/extract"
log "$(T "paket siap, aksi $ACTION" "package ready, action $ACTION")"
mkdir -p "$EXTRACT"
if command -v docker >/dev/null 2>&1 && [ "${GARUDADECK_FORCE_API:-0}" != "1" ]; then
  spin_pull "$(T "siapkan paket installer" "prepare installer package")" docker pull "$PKG_REAL" >/dev/null 2>&1 || fail "$(T "gagal siapkan paket, cek koneksi" "failed to prepare package, check connection")"
  CID="$(docker create "$PKG_REAL")"
  docker cp "$CID:/theme.tar.gz" "$ARCHIVE" || fail "$(T "gagal salin dari image" "failed to copy from image")"
  docker rm "$CID" >/dev/null
  ok "$(T "paket ketarik, lanjut $ACTION" "package pulled, continue $ACTION")"
else
  need python3
  log "$(T "siapkan paket installer" "prepare installer package")"
  TOKEN="$(curl -fsSL "https://ghcr.io/token?service=ghcr.io&scope=repository:${OWNER_LC}/garudadeck-theme:pull" | python3 -c "import json,sys; print(json.load(sys.stdin).get('token',''))")"
  [ -n "$TOKEN" ] || fail "$(T "gagal siapkan unduhan, cek koneksi" "failed to prepare download, check connection")"
  ACCEPT="application/vnd.oci.image.index.v1+json, application/vnd.docker.distribution.manifest.list.v2+json, application/vnd.oci.image.manifest.v1+json, application/vnd.docker.distribution.manifest.v2+json"
  MANIFEST="$(curl -fsSL -H "Authorization: Bearer $TOKEN" -H "Accept: $ACCEPT" "https://ghcr.io/v2/${OWNER_LC}/garudadeck-theme/manifests/${TAG}")" || fail "$(T "paket tidak ketemu, coba lagi nanti" "package not found, try again later")"
  case "$(uname -m)" in
    x86_64) PLAT="amd64" ;;
    aarch64|arm64) PLAT="arm64" ;;
    *) PLAT="$(uname -m)" ;;
  esac
  MDIGEST="$(echo "$MANIFEST" | PLAT="$PLAT" python3 -c "import json,sys,os; d=json.load(sys.stdin); p=os.environ['PLAT']; print(next((m['digest'] for m in d.get('manifests',[]) if m.get('platform',{}).get('os')=='linux' and m.get('platform',{}).get('architecture')==p), ''))")"
  if [ -n "$MDIGEST" ]; then
    MANIFEST="$(curl -fsSL -H "Authorization: Bearer $TOKEN" -H "Accept: $ACCEPT" "https://ghcr.io/v2/${OWNER_LC}/garudadeck-theme/manifests/${MDIGEST}")" || fail "$(T "paket tidak cocok untuk mesin ini" "package mismatch for this machine")"
  fi
  DIGEST="$(echo "$MANIFEST" | python3 -c "import json,sys; d=json.load(sys.stdin); ls=d.get('layers',[]); print(ls[-1]['digest'] if ls else '')")"
  [ -n "$DIGEST" ] || fail "$(T "paket tidak lengkap, coba lagi nanti" "package incomplete, try again later")"
  spin_pull "$(T "siapkan paket installer" "prepare installer package")" curl -fsSL -H "Authorization: Bearer $TOKEN" "https://ghcr.io/v2/${OWNER_LC}/garudadeck-theme/blobs/$DIGEST" -o "$TMP_DIR/layer.tar" >/dev/null 2>&1 || fail "$(T "gagal siapkan paket, cek koneksi" "failed to prepare package, check connection")"
  LAYERTMP="$(mktemp -d)"
  tar -xzf "$TMP_DIR/layer.tar" -C "$LAYERTMP" || fail "$(T "ekstrak layer gagal" "layer extract failed")"
  FOUND_LAYER="$(find "$LAYERTMP" -name "theme.tar.gz" | head -1)"
  [ -n "$FOUND_LAYER" ] || fail "theme.tar.gz $(T "tidak ada di image" "missing in image")"
  cp "$FOUND_LAYER" "$ARCHIVE"
fi
tar -xzf "$ARCHIVE" -C "$EXTRACT" || fail "$(T "arsip rusak" "archive broken")"
SWITCHER="$EXTRACT/theme-switcher"
[ -f "$SWITCHER/install.sh" ] || fail "install.sh $(T "tidak ketemu di paket" "missing in package")"
log "$(T "paket siap, jalanin $ACTION sekarang" "package ready, running $ACTION now")"
PANEL_DIR="$PANEL_DIR" GARUDADECK_LANG="$GD_LANG" GD_LANG="$GD_LANG" bash "$SWITCHER/install.sh" "$ACTION"
