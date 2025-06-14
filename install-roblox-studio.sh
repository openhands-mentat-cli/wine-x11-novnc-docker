#!/bin/bash
set -e

echo "Installing Roblox Studio..."

# Configure Wine for better Windows app compatibility
export WINEARCH=win64
export WINEPREFIX=/root/roblox-prefix

# Initialize Wine prefix for 64-bit (Roblox Studio requires 64-bit)
echo "Initializing 64-bit Wine prefix..."
/usr/bin/wineboot --init

# Install necessary Windows components for Roblox Studio
echo "Installing Windows components..."
/usr/bin/winetricks -q corefonts vcrun2019 dotnet48

# Download Roblox Studio Installer
echo "Downloading Roblox Studio..."
cd /tmp
wget -O RobloxStudioLauncherBeta.exe "https://setup.rbxcdn.com/RobloxStudioLauncherBeta.exe"

# Install Roblox Studio
echo "Installing Roblox Studio (this may take a while)..."
/usr/bin/wine RobloxStudioLauncherBeta.exe /S

echo "Roblox Studio installation completed!"

# Create desktop shortcut
mkdir -p /root/Desktop
cat > "/root/Desktop/Roblox Studio.desktop" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Roblox Studio
Comment=Roblox Studio Game Development
Exec=env WINEPREFIX=/root/roblox-prefix /usr/bin/wine "/root/roblox-prefix/drive_c/users/root/AppData/Local/Roblox/Versions/RobloxStudio.exe"
Icon=applications-games
Terminal=false
Categories=Game;Development;
EOF

chmod +x "/root/Desktop/Roblox Studio.desktop"

echo "Desktop shortcut created!"
