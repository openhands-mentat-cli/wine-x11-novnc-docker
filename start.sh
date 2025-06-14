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

# Initialize wine prefix if it doesn't exist
if [ ! -d "$WINEPREFIX" ]; then
    echo "Initializing 64-bit Wine prefix at $WINEPREFIX"
    export WINEARCH=win64
    /usr/bin/wineboot --init
    
    # Install basic Windows components for better compatibility
    echo "Installing basic Windows components..."
    /usr/bin/winetricks -q corefonts vcrun2019 || echo "Some components may have failed to install, continuing..."
fi

# Start supervisord
echo "Starting supervisord..."
exec /usr/bin/supervisord
