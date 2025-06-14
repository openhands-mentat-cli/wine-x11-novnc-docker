#!/bin/bash
set -e

# Set default port if not provided by Railway
export PORT=${PORT:-8080}

echo "=========================================="
echo "Starting Wine+X11+noVNC Docker Container"
echo "Port: $PORT"
echo "Time: $(date)"
echo "=========================================="

# Update supervisord configuration with the correct port
echo "Configuring noVNC to listen on port $PORT"
sed -i "s/--listen 8080/--listen $PORT/g" /etc/supervisor/conf.d/supervisord.conf

# Configure Wine environment for container
export WINEDLLOVERRIDES="mscoree,mshtml="
export DISPLAY=:0

# Initialize wine prefix if it doesn't exist
if [ ! -d "$WINEPREFIX" ]; then
    echo "Initializing 64-bit Wine prefix at $WINEPREFIX"
    export WINEARCH=win64
    
    # Wait for X11 to be ready
    echo "Waiting for X11 server..."
    timeout 30 bash -c 'until xdpyinfo >/dev/null 2>&1; do sleep 1; done' || echo "X11 timeout, continuing..."
    
    # Initialize Wine
    /usr/bin/wineboot --init
    
    # Configure Wine for GUI applications
    echo "Configuring Wine for GUI applications..."
    /usr/bin/winecfg /v win10 2>/dev/null || echo "winecfg failed, continuing..."
    
    # Clear any corrupted cached files
    rm -rf /root/.cache/winetricks/vcrun2019/* 2>/dev/null || true
    
    # Install basic Windows components for better compatibility
    echo "Installing basic Windows components..."
    /usr/bin/winetricks -q --force corefonts vcrun2019 || echo "Some components may have failed to install, continuing..."
fi

# Start supervisord
echo "Starting supervisord..."
exec /usr/bin/supervisord
