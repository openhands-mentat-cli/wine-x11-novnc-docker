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
    echo "Initializing Wine prefix at $WINEPREFIX"
    /usr/bin/wineboot --init
fi

# Start supervisord
echo "Starting supervisord..."
exec /usr/bin/supervisord
