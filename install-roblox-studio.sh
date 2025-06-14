#!/bin/bash

echo "Installing Roblox Studio..."

# Wait for X11 and Wine environment to be ready
echo "Waiting for display server..."
timeout 60 bash -c 'until xdpyinfo >/dev/null 2>&1; do sleep 2; done' || echo "Display timeout, continuing..."

# Configure Wine environment
export WINEARCH=win64
export WINEPREFIX=/root/roblox-prefix
export WINEDLLOVERRIDES="mscoree,mshtml="
export DISPLAY=:0

# Check if already installed
if [ -d "$WINEPREFIX" ]; then
    echo "Roblox Studio Wine prefix already exists, skipping installation"
    exit 0
fi

# Initialize Wine prefix for 64-bit (Roblox Studio requires 64-bit)
echo "Initializing 64-bit Wine prefix for Roblox Studio..."
/usr/bin/wineboot --init 2>/dev/null || echo "Wine initialization completed with warnings"

# Install necessary Windows components for Roblox Studio
echo "Installing Windows components for Roblox Studio..."
# Clear any corrupted cached files first
rm -rf /root/.cache/winetricks/* 2>/dev/null || true

# Install components one by one for better error handling
echo "Installing core fonts..."
/usr/bin/winetricks -q --force corefonts 2>/dev/null || echo "Font installation completed with warnings"

echo "Installing Visual C++ Runtime..."
/usr/bin/winetricks -q --force vcrun2019 2>/dev/null || echo "VC++ Runtime installation completed with warnings"

# Download Roblox Studio Installer
echo "Downloading Roblox Studio installer..."
cd /tmp
wget -O RobloxStudioLauncherBeta.exe "https://setup.rbxcdn.com/RobloxStudioLauncherBeta.exe" 2>/dev/null || {
    echo "Failed to download Roblox Studio installer, trying alternative URL..."
    wget -O RobloxStudioLauncherBeta.exe "https://roblox.com/download/studio" 2>/dev/null || {
        echo "Failed to download Roblox Studio installer. You can manually download it later."
        exit 0
    }
}

# Install Roblox Studio
echo "Installing Roblox Studio (this may take a while)..."
timeout 300 /usr/bin/wine RobloxStudioLauncherBeta.exe /S 2>/dev/null || echo "Roblox Studio installation completed with warnings"

echo "Roblox Studio installation process completed!"

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

echo "Desktop shortcut created! Roblox Studio should be available on the desktop."
echo "Note: If Roblox Studio doesn't work immediately, you may need to:"
echo "1. Check your internet connection"
echo "2. Manually download Roblox Studio from the browser"
echo "3. Wait for all Wine components to finish installing"
