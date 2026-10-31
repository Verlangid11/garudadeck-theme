#!/bin/bash
# Theme Pterodactyl GarudaDeck by verlangid from Indonesia
# Smart CLI wrapper, ID EN, public via GHCR, silent pull, y/n critical, auto update tools.
set -euo pipefail
SELF_URL="https://raw.githubusercontent.com/Verlangid11/garudadeck-theme/main/install.sh"
if [ "$(id -u)" != "0" ]; then
  if command -v sudo >/dev/null 2>&1; then
    if [ -f "${0:-}" ] && [ "${0:-bash}" != "bash" ] && [ "$0" != "-bash" ] && [ "$0" != "/dev/fd/63" ] && [[ "$0" != /dev/fd/* ]]; then
      exec sudo -E bash "$0" "$@"
    else
      TMP_SELF="$(mktemp /tmp/gdcli.XXXXXX)"
      curl -fsSL "$SELF_URL" -o "$TMP_SELF"
      chmod +x "$TMP_SELF"
      exec sudo -E bash "$TMP_SELF" "$@"
    fi
  else
    echo "ERROR: run as root or install sudo first" >&2
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
if [ $# -eq 0 ] && [ ! -t 0 ]; then
  GD_LANG="${GD_LANG:-id}"
  set -- install
fi
C_RESET="\033[0m"; C_GREY="\033[90m"; C_DARK="\033[38;5;235m"; C_PURPLE="\033[38;5;93m"; C_BLUE="\033[38;5;39m"; C_VIOLET="\033[38;5;135m"; C_WHITE="\033[37m"; C_GREEN="\033[38;5;42m"; C_RED="\033[38;5;196m"; C_YELLOW="\033[38;5;226m"
say() { printf "%b%s%b\n" "$1" "$2" "$C_RESET"; }
is_en() { [ "$GD_LANG" = "en" ]; }
T() { if is_en; then printf "%s" "$2"; else printf "%s" "$1"; fi; }
banner() {
  clear 2>/dev/null || true
  say "$C_PURPLE" "   ____                      _       ____            _"
  say "$C_PURPLE" "  / ___| __ _ _ __ _   _  __| | __ _|  _ \\  ___  ___| | __"
  say "$C_VIOLET" " | |  _ / _\` | '__| | | |/ _\` |/ _\` | | | |/ _ \\/ __| |/ /"
  say "$C_BLUE" " | |_| | (_| | |  | |_| | (_| | (_| | |_| |  __/ (__|   <"
  say "$C_GREY" "  \\____|\\__,_|_|   \\__,_|\\__,_|\\__,_|____/ \\___|\\___|_|\\_\\"
  say "$C_PURPLE" "  Theme Pterodactyl GarudaDeck"
  say "$C_GREY" "  by verlangid from Indonesia | v1.15.2 | MIT"
  echo ""
}
lang_menu() {
  banner
  say "$C_WHITE" "  Choose language / Pilih bahasa:"
  say "$C_BLUE" "  [1] Indonesia"
  say "$C_PURPLE" "  [2] English"
  echo ""
  printf "%b" "$C_GREY"
  read -r -p "  garudadeck@panel:~\$ lang [1-2] (default 1): " LANG_PICK
  printf "%b" "$C_RESET"
  LANG_PICK="${LANG_PICK:-1}"
  case "$LANG_PICK" in
    2|en|EN|english|English) GD_LANG="en" ;; *) GD_LANG="id" ;;
  esac
  export GARUDADECK_LANG="$GD_LANG"
  export GD_LANG="$GD_LANG"
}
confirm() {
  local qid="$1" qen="$2"
  local ans=""
  if [ -t 0 ]; then
    printf "%b" "$C_YELLOW"
    read -r -p "  garudadeck@panel:~\$ $(T "$qid" "$qen") [y/N]: " ans
    printf "%b" "$C_RESET"
  elif [ -r /dev/tty ]; then
    printf "%b" "$C_YELLOW" > /dev/tty
    read -r -p "  garudadeck@panel:~\$ $(T "$qid" "$qen") [y/N]: " ans < /dev/tty
    printf "%b" "$C_RESET" > /dev/tty
  else
    return 1
  fi
  case "$ans" in y|Y|ya|YA|yes|YES) return 0 ;; *) return 1 ;; esac
}
menu() {
  banner
  if is_en; then
    say "$C_WHITE" "  Select action:"
    say "$C_BLUE" "  [1] Install panel"
    say "$C_GREY" "  [2] Check system"
    say "$C_VIOLET" "  [3] Backup"
    say "$C_PURPLE" "  [4] Rollback"
    say "$C_RED" "  [6] Uninstall to vanilla"
    say "$C_GREY" "  [0] Language  [5] Exit"
  else
    say "$C_WHITE" "  Pilih aksi:"
    say "$C_BLUE" "  [1] Install panel"
    say "$C_GREY" "  [2] Cek sistem"
    say "$C_VIOLET" "  [3] Backup"
    say "$C_PURPLE" "  [4] Rollback"
    say "$C_RED" "  [6] Uninstall ke vanilla"
    say "$C_GREY" "  [0] Bahasa  [5] Keluar"
  fi
  echo ""
  say "$C_DARK" "  ─────────────────────────────"
  printf "%b" "$C_GREY"
  if [ -t 0 ]; then
    read -r -p "  garudadeck@panel:~\$ run [0-6] (default 1): " PICK
  elif [ -r /dev/tty ]; then
    read -r -p "  garudadeck@panel:~\$ run [0-6] (default 1): " PICK < /dev/tty
  else
    PICK="1"
  fi
  printf "%b" "$C_RESET"
  PICK="${PICK:-1}"
  case "$PICK" in
    1) ACTION="install" ;; 2) ACTION="check" ;; 3) ACTION="backup" ;; 4) ACTION="rollback" ;; 6) ACTION="uninstall" ;;
    0) lang_menu; menu; return 0 ;;
    5) say "$C_GREEN" "  $(T "Sampai jumpa." "Bye.")"; exit 0 ;;
    *) ACTION="install" ;;
  esac
}
spinner() {
  local msg="$1"; shift
  local frames="⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏"
  printf "%b" "$C_PURPLE" >&2
  "$@" >"$TMP_DIR/job.log" 2>&1 &
  local pid=$!
  local i=0
  while kill -0 $pid 2>/dev/null; do
    i=$(( (i + 1) % 10 ))
    printf "\r  %s %s" "$(echo "$frames" | cut -d' ' -f$((i + 1)))" "$msg" >&2
    sleep 0.12
  done
  wait $pid
  local code=$?
  printf "\r%b" "$C_RESET" >&2
  return $code
}
PACKAGE="${PACKAGE:-ghcr.io/verlangid11/garudadeck-theme}"
TAG="${GARUDADECK_TAG:-latest}"
PANEL_DIR="${PANEL_DIR:-/var/www/pterodactyl}"
ACTION=""
if [ $# -gt 0 ]; then
  case "${1:-}" in install|check|backup|rollback|uninstall) ACTION="$1"; shift || true ;; *) ACTION="" ;; esac
fi
if [ -z "$GD_LANG" ]; then
  if [ -t 0 ] || [ -r /dev/tty ]; then
    if [ -t 0 ]; then lang_menu; else lang_menu </dev/tty; fi
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
case "$ACTION" in install|check|backup|rollback|uninstall) ;; *) ACTION="install" ;; esac
if [ "$ACTION" = "install" ]; then
  confirm "Lanjut install GarudaDeck" "Continue GarudaDeck install" || { say "$C_GREY" "  $(T "Dibatalkan." "Cancelled.")"; exit 0; }
fi
if [ "$ACTION" = "uninstall" ]; then
  confirm "Uninstall ke vanilla resmi, lanjut" "Uninstall to official vanilla, continue" || { say "$C_GREY" "  $(T "Dibatalkan." "Cancelled.")"; exit 0; }
fi
if [ "$ACTION" = "rollback" ]; then
  confirm "Rollback ke backup terakhir, lanjut" "Rollback to latest backup, continue" || { say "$C_GREY" "  $(T "Dibatalkan." "Cancelled.")"; exit 0; }
fi
TMP_DIR="$(mktemp -d)"
cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT
log() { say "$C_GREY" "  ○ $1"; }
ok() { say "$C_GREEN" "  ● $1"; }
fail() { say "$C_RED" "  ✕ ERROR: $1"; exit 1; }
need() { command -v "$1" >/dev/null 2>&1 || fail "$1 $(T "belum ada." "missing.")"; }
auto_update_tools() {
  local missing=0
  for b in curl tar rsync; do command -v "$b" >/dev/null 2>&1 || missing=1; done
  if ! command -v mysqldump >/dev/null 2>&1; then missing=1; fi
  if [ "$missing" = "1" ]; then
    log "$(T "Auto update tools yang kurang..." "Auto updating missing tools...")"
    apt-get update -qq >/dev/null 2>&1 || true
    command -v rsync >/dev/null 2>&1 || apt-get install -y -qq rsync >/dev/null 2>&1 || true
    command -v mysqldump >/dev/null 2>&1 || apt-get install -y -qq mariadb-client >/dev/null 2>&1 || true
    command -v curl >/dev/null 2>&1 || apt-get install -y -qq curl >/dev/null 2>&1 || true
    command -v tar >/dev/null 2>&1 || apt-get install -y -qq tar >/dev/null 2>&1 || true
  fi
  if ! command -v composer >/dev/null 2>&1; then
    if [ -f "$PANEL_DIR/vendor/autoload.php" ]; then
      log "$(T "Composer dilewati, vendor sudah ada." "Composer skipped, vendor present.")"
    else
      log "$(T "Auto pasang composer..." "Auto installing composer...")"
      curl -fsSL https://getcomposer.org/installer -o /tmp/composer-setup.php >/dev/null 2>&1 || true
      php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer --quiet >/dev/null 2>&1 || true
      rm -f /tmp/composer-setup.php
    fi
  fi
}
find_panel() {
  if [ -f "$1/config/app.php" ] && [ -f "$1/artisan" ]; then echo "$1"; return 0; fi
  return 1
}
banner
say "$C_GREY" "  garudadeck@panel:~\$ $ACTION"
auto_update_tools
if ! find_panel "$PANEL_DIR" >/dev/null 2>&1; then
  FOUND=""
  for d in /var/www/pterodactyl /var/www/panel /srv/pterodactyl /opt/pterodactyl; do
    if find_panel "$d" >/dev/null 2>&1; then FOUND="$d"; break; fi
  done
  if [ -n "$FOUND" ]; then
    PANEL_DIR="$FOUND"
  else
    fail "$(T "Panel tidak ketemu." "Panel not found.")"
  fi
fi
need curl
need tar
OWNER_LC="$(echo "$PACKAGE" | cut -d/ -f2 | tr '[:upper:]' '[:lower:]')"
PKG_REAL="ghcr.io/${OWNER_LC}/garudadeck-theme:${TAG}"
ARCHIVE="$TMP_DIR/theme.tar.gz"
EXTRACT="$TMP_DIR/extract"
mkdir -p "$EXTRACT"
if command -v docker >/dev/null 2>&1 && [ "${GARUDADECK_FORCE_API:-0}" != "1" ]; then
  spinner "$(T "Menyiapkan paket..." "Preparing package...")" docker pull "$PKG_REAL" >/dev/null 2>&1 || fail "$(T "Gagal unduh paket." "Package download failed.")"
  CID="$(docker create "$PKG_REAL" 2>/dev/null)"
  docker cp "$CID:/theme.tar.gz" "$ARCHIVE" >/dev/null 2>&1 || fail "$(T "Gagal salin paket." "Package copy failed.")"
  docker rm "$CID" >/dev/null 2>&1 || true
  ok "$(T "Paket siap." "Package ready.")"
else
  need python3
  spinner "$(T "Menyiapkan paket..." "Preparing package...")" curl -fsSL "https://ghcr.io/token?service=ghcr.io" >/dev/null 2>&1 || true
  TOKEN="$(curl -fsSL "https://ghcr.io/token?service=ghcr.io&scope=repository:${OWNER_LC}/garudadeck-theme:pull" 2>/dev/null | python3 -c "import json,sys; print(json.load(sys.stdin).get('token',''))" 2>/dev/null)"
  [ -n "$TOKEN" ] || fail "$(T "Gagal auth paket." "Package auth failed.")"
  ACCEPT="application/vnd.oci.image.index.v1+json, application/vnd.docker.distribution.manifest.list.v2+json, application/vnd.oci.image.manifest.v1+json, application/vnd.docker.distribution.manifest.v2+json"
  MANIFEST="$(curl -fsSL -H "Authorization: Bearer $TOKEN" -H "Accept: $ACCEPT" "https://ghcr.io/v2/${OWNER_LC}/garudadeck-theme/manifests/${TAG}" 2>/dev/null)" || fail "$(T "Paket tidak ketemu." "Package not found.")"
  case "$(uname -m)" in
    x86_64) PLAT="amd64" ;;
    aarch64|arm64) PLAT="arm64" ;;
    *) PLAT="$(uname -m)" ;;
  esac
  MDIGEST="$(echo "$MANIFEST" | PLAT="$PLAT" python3 -c "import json,sys,os; d=json.load(sys.stdin); p=os.environ['PLAT']; print(next((m['digest'] for m in d.get('manifests',[]) if m.get('platform',{}).get('os')=='linux' and m.get('platform',{}).get('architecture')==p), ''))" 2>/dev/null)"
  if [ -n "$MDIGEST" ]; then
    MANIFEST="$(curl -fsSL -H "Authorization: Bearer $TOKEN" -H "Accept: $ACCEPT" "https://ghcr.io/v2/${OWNER_LC}/garudadeck-theme/manifests/${MDIGEST}" 2>/dev/null)" || fail "$(T "Paket tidak cocok." "Package mismatch.")"
  fi
  DIGEST="$(echo "$MANIFEST" | python3 -c "import json,sys; d=json.load(sys.stdin); ls=d.get('layers',[]); print(ls[-1]['digest'] if ls else '')" 2>/dev/null)"
  [ -n "$DIGEST" ] || fail "$(T "Paket rusak." "Package broken.")"
  spinner "$(T "Menyiapkan paket..." "Preparing package...")" curl -fsSL -H "Authorization: Bearer $TOKEN" "https://ghcr.io/v2/${OWNER_LC}/garudadeck-theme/blobs/$DIGEST" -o "$TMP_DIR/layer.tar" >/dev/null 2>&1 || fail "$(T "Gagal unduh paket." "Package download failed.")"
  LAYERTMP="$(mktemp -d)"
  tar -xzf "$TMP_DIR/layer.tar" -C "$LAYERTMP" >/dev/null 2>&1 || fail "$(T "Ekstrak gagal." "Extract failed.")"
  FOUND_LAYER="$(find "$LAYERTMP" -name "theme.tar.gz" | head -1)"
  [ -n "$FOUND_LAYER" ] || fail "theme.tar.gz $(T "hilang." "missing.")"
  cp "$FOUND_LAYER" "$ARCHIVE" >/dev/null 2>&1
  ok "$(T "Paket siap." "Package ready.")"
fi
tar -xzf "$ARCHIVE" -C "$EXTRACT" >/dev/null 2>&1 || fail "$(T "Arsip rusak." "Archive broken.")"
SWITCHER="$EXTRACT/theme-switcher"
[ -f "$SWITCHER/install.sh" ] || fail "install.sh $(T "hilang." "missing.")"
say "$C_PURPLE" "  ─────────────────────────────"
PANEL_DIR="$PANEL_DIR" GARUDADECK_LANG="$GD_LANG" GD_LANG="$GD_LANG" bash "$SWITCHER/install.sh" "$ACTION"
