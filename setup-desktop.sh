#!/bin/bash
set -e

echo "Setting up modern desktop environment..."

# Wait for XFCE to start
sleep 5

# Create Desktop directory
mkdir -p /root/Desktop
mkdir -p /root/.config/xfce4/desktop

# Create Firefox shortcut
cat > "/root/Desktop/Firefox.desktop" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Firefox Web Browser
Comment=Browse the World Wide Web
GenericName=Web Browser
Keywords=Internet;WWW;Browser;Web;Explorer
Exec=firefox %u
Terminal=false
X-MultipleArgs=false
Icon=firefox
Categories=GNOME;GTK;Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;video/webm;application/x-xpinstall;
StartupNotify=true
EOF

chmod +x "/root/Desktop/Firefox.desktop"

# Configure XFCE settings for a modern look
mkdir -p /root/.config/xfce4/xfconf/xfce-perchannel-xml

# Set up wallpaper and theme
cat > "/root/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-desktop" version="1.0">
  <property name="backdrop" type="empty">
    <property name="screen0" type="empty">
      <property name="monitor0" type="empty">
        <property name="workspace0" type="empty">
          <property name="color-style" type="int" value="0"/>
          <property name="image-style" type="int" value="5"/>
          <property name="last-image" type="string" value="/usr/share/pixmaps/xfce-blue.jpg"/>
        </property>
      </property>
    </property>
  </property>
</channel>
EOF

# Install Roblox Studio after desktop is ready
echo "Installing Roblox Studio..."
/root/install-roblox-studio.sh &

echo "Desktop setup completed!"
