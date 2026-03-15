#!/bin/bash

# Warna
RED="\033[1;31m"
GREEN="\033[1;32m"
CYAN="\033[1;36m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET="\033[0m"
BOLD="\033[1m"
VERSION="5.0"

clear
echo -e "${CYAN}${BOLD}"
echo -e "${RESET}"
echo -e "${RED}𝗢𝗪𝗡𝗘𝗥${BLUE}𝗗𝗘𝗩𝗘𝗟𝗢𝗣𝗘𝗥${RESET}"
echo -e "\033[31mTELEGRAM : t.me/yunback\033[0m"
echo -e "\033[1;33m©yun xiao\033[0m"
echo ""
echo "╔═══════════════════════════════════════════════════════════════════╗"
echo "║                                                                   ║"
echo "║                      __====-_  _-====__                           ║"
echo "║                _--^^^#####//      \#####^^^--_                    ║"
echo "║             _-^##########// (    ) \##########^-_                 ║"
echo "║            -############//  |\^^/|  \############-                ║"
echo "║          _/############//   (@::@)   \############\_              ║"
echo "║         /#############((     \\//     ))#############\             ║"
echo "║        -###############\\    (oo)    //###############-            ║"
echo "║       -#################\\  / VV \  //#################-           ║"
echo "║      -###################\\/      \//###################-          ║"
echo "║     _#/|##########/\######(   /\   )######/\##########|\#_         ║"
echo "║     |/ |#/\#/\#/\/  \#/\##\  |  |  /##/\#/  \/\#/\#/\#| \|         ║"
echo "║     '  |/  V  V  '   V  \#\| |  | |/#/  V   '  V  V  \|  '         ║"
echo "║        '   '  '      '   / | |  | | \   '      '  '   '            ║"
echo "║                         (  | |  | |  )                             ║"
echo "║                          \ | |  | | /                              ║"
echo "║                           \| |  | |/                               ║"
echo "║                            ' |  | '                                ║"
echo "║                              \__/                                  ║"
echo "║                                                                   ║"
echo "║        🛡️  YUN XIAO PROTECT + PANEL NIH DEKS🛡️                      ║"
echo "║                    Version $VERSION                                ║"
echo "╚═══════════════════════════════════════════════════════════════════╝"
echo ""

# Cek root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Script ini harus dijalankan sebagai root!"
  exit 1
fi

# Pindah ke folder Pterodactyl
cd /var/www/pterodactyl || { echo "❌ Folder /var/www/pterodactyl tidak ditemukan!"; exit 1; }

echo -e "${YELLOW}${BOLD}Pilih mode yang ingin dijalankan:${RESET}"
echo ""
echo -e "${GREEN}[1]${RESET} 🔐 Install Protect (Add Protect)"
echo -e "${GREEN}[2]${RESET} ♻️ Konfigurasi protect"
echo -e "${YELLOW}[3]${RESET} 🚀 Reset Default"
echo -e "${GREEN}[4]${RESET} Keluar"
echo ""

read -p "$(echo -e ${CYAN}${BOLD}"Masukkan pilihan (1/2/3/4): "${RESET})" choice


case $choice in
  1)
    echo "🛡️ Menerapkan proteksi..."
    bash <(curl -s https://raw.githubusercontent.com/yun-xiaogt/panel/refs/heads/main/protect.sh)
    ;;
  
  2)
    echo "📖 Konfigurasi proteksi saat ini:"
    php artisan tinker --execute='
use Pterodactyl\Models\ProtectionSetting;
echo "Admin IDs: " . ProtectionSetting::get("admin_ids") . PHP_EOL;
echo "Access Denied Message: " . ProtectionSetting::get("access_denied_message") . PHP_EOL;
echo "Server Delete Protection: " . (ProtectionSetting::isProtectionEnabled("server_delete") ? "Aktif" : "Nonaktif") . PHP_EOL;
echo "User Management Protection: " . (ProtectionSetting::isProtectionEnabled("user_management") ? "Aktif" : "Nonaktif") . PHP_EOL;
echo "Location Access Protection: " . (ProtectionSetting::isProtectionEnabled("location_access") ? "Aktif" : "Nonaktif") . PHP_EOL;
echo "Nodes Access Protection: " . (ProtectionSetting::isProtectionEnabled("nodes_access") ? "Aktif" : "Nonaktif") . PHP_EOL;
echo "Nests Access Protection: " . (ProtectionSetting::isProtectionEnabled("nests_access") ? "Aktif" : "Nonaktif") . PHP_EOL;
echo "Server Modification Protection: " . (ProtectionSetting::isProtectionEnabled("server_modification") ? "Aktif" : "Nonaktif") . PHP_EOL;
echo "File Access Protection: " . (ProtectionSetting::isProtectionEnabled("file_access") ? "Aktif" : "Nonaktif") . PHP_EOL;
echo "Settings Access Protection: " . (ProtectionSetting::isProtectionEnabled("settings_access") ? "Aktif" : "Nonaktif") . PHP_EOL;
echo "API Management Protection: " . (ProtectionSetting::isProtectionEnabled("api_management") ? "Aktif" : "Nonaktif") . PHP_EOL;
'
    ;;
  
  3)
    echo "🔄 Reset ke default settings..."
    php artisan tinker --execute='
use Pterodactyl\Models\ProtectionSetting;
ProtectionSetting::set("admin_ids", "1", "List of admin IDs that can access protection settings (comma separated)");
ProtectionSetting::set("access_denied_message", "Akses ditolak: Anda tidak memiliki izin untuk mengakses fitur ini.", "Message shown when access is denied");
ProtectionSetting::set("protection_server_delete", "true", "Protect server deletion");
ProtectionSetting::set("protection_user_management", "true", "Protect user management");
ProtectionSetting::set("protection_location_access", "true", "Protect location access");
ProtectionSetting::set("protection_nodes_access", "true", "Protect nodes access");
ProtectionSetting::set("protection_nests_access", "true", "Protect nests access");
ProtectionSetting::set("protection_server_modification", "true", "Protect server modification");
ProtectionSetting::set("protection_file_access", "true", "Protect file access");
ProtectionSetting::set("protection_settings_access", "true", "Protect settings access");
ProtectionSetting::set("protection_api_management", "true", "Protect API management");
echo "Settings reset to default!" . PHP_EOL;
'
    echo "✅ Settings telah di-reset ke default!"
    ;;
  
  4)
    echo "👋 Keluar..."
    exit 0
    ;;
  
  *)
    echo "❌ Pilihan tidak valid!"
    exit 1
    ;;
esac

echo ""
echo "✅ Selesai! Kunjungi /admin/protection untuk mengatur konfigurasi lebih lanjut."
