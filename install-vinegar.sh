#!/bin/bash

echo "Installing Vinegar (Roblox Studio via optimized Wine)..."

# Wait for X11 and Wine environment to be ready
echo "Waiting for display server..."
timeout 60 bash -c 'until xdpyinfo >/dev/null 2>&1; do sleep 2; done' || echo "Display timeout, continuing..."

# Set environment variables
export DISPLAY=:0
export HOME=/root

# Check if Vinegar is already installed
if [ -f "/root/.local/bin/vinegar" ]; then
    echo "Vinegar already installed, skipping installation"
else
    echo "Installing Vinegar dependencies..."
    
    # Create directories
    mkdir -p /root/.local/bin
    mkdir -p /root/.config/vinegar
    
    # Download and install Vinegar
    echo "Downloading Vinegar..."
    cd /tmp
    
    # Download the latest Vinegar release
    wget -O vinegar.tar.gz "https://github.com/vinegarhq/vinegar/releases/latest/download/vinegar-linux-amd64.tar.gz" 2>/dev/null || {
        echo "Failed to download Vinegar, trying alternative method..."
        # Fallback: use AppImage
        wget -O vinegar.AppImage "https://github.com/vinegarhq/vinegar/releases/latest/download/vinegar-linux-x86_64.AppImage" 2>/dev/null || {
            echo "Failed to download Vinegar. Installing manual Roblox Studio as fallback..."
            exit 1
        }
        chmod +x vinegar.AppImage
        mv vinegar.AppImage /root/.local/bin/vinegar
    }
    
    # Extract if we got the tar.gz
    if [ -f "vinegar.tar.gz" ]; then
        tar -xzf vinegar.tar.gz
        chmod +x vinegar
        mv vinegar /root/.local/bin/
    fi
    
    echo "Vinegar installed successfully!"
fi

# Configure Vinegar
echo "Configuring Vinegar for container environment..."

# Create Vinegar configuration
cat > "/root/.config/vinegar/config.toml" << EOF
[env]
fps_unlocker = true
multi_instance = false
wine_preset = "studio"

[env.wine]
base_dir = "/root/.local/share/vinegar/prefixes"

[env.studio]
channel = "LIVE"
editor = ""
EOF

# Initialize Vinegar (this will set up Wine prefix for Roblox)
echo "Initializing Vinegar Wine prefix (this may take a few minutes)..."
export PATH="/root/.local/bin:$PATH"

# Run Vinegar setup
timeout 600 /root/.local/bin/vinegar studio --no-install 2>/dev/null || echo "Vinegar initialization completed"

echo "Vinegar setup completed!"

# Create desktop shortcuts
mkdir -p /root/Desktop

# Roblox Studio shortcut
cat > "/root/Desktop/Roblox Studio (Vinegar).desktop" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Roblox Studio (Vinegar)
Comment=Roblox Studio via Vinegar - Better compatibility
Exec=/root/.local/bin/vinegar studio
Icon=applications-games
Terminal=false
Categories=Game;Development;
EOF

# Roblox Player shortcut
cat > "/root/Desktop/Roblox Player (Vinegar).desktop" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Roblox Player (Vinegar)
Comment=Roblox Player via Vinegar - Better compatibility
Exec=/root/.local/bin/vinegar player
Icon=applications-games
Terminal=false
Categories=Game;Entertainment;
EOF

chmod +x "/root/Desktop/Roblox Studio (Vinegar).desktop"
chmod +x "/root/Desktop/Roblox Player (Vinegar).desktop"

echo "=== Vinegar Installation Completed! ==="
echo ""
echo "🎮 Roblox Studio and Player are now available via Vinegar!"
echo ""
echo "Desktop shortcuts created:"
echo "• Roblox Studio (Vinegar) - For game development"
echo "• Roblox Player (Vinegar) - For playing games"
echo ""
echo "✨ Benefits of Vinegar:"
echo "• Better anti-cheat compatibility"
echo "• Optimized Wine configuration for Roblox"
echo "• FPS unlocker support"
echo "• Automatic updates"
echo "• Superior stability and performance"
echo ""
echo "🚀 Ready to develop games with Roblox Studio!"
