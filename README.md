## wine-x11-novnc-docker

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/solarkennedy/wine-x11-novnc-docker/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/solarkennedy/wine-x11-novnc-docker)

🎮 **Modern Wine Desktop with Roblox Studio Support**

A containerized Wine environment accessible via web browser, featuring a modern XFCE desktop and pre-installed Roblox Studio for game development!

This container runs:

* **Xvfb** - X11 in a virtual framebuffer
* **x11vnc** - A VNC server that scrapes the above X11 server
* **[noVNC](https://kanaka.github.io/noVNC/)** - A HTML5 canvas VNC viewer
* **XFCE4** - Modern, lightweight desktop environment
* **Firefox** - Modern web browser
* **Wine 64-bit** - Windows compatibility layer
* **Roblox Studio** - Game development environment (auto-installed)

This is a [trusted build](https://registry.hub.docker.com/u/solarkennedy/wine-x11-novnc-docker/)
on the Docker Hub.

## Run It

### Local Development

    # Start the container
    docker run --rm -p 8080:8080 solarkennedy/wine-x11-novnc-docker

    # Show the container ID (this is the VNC password)
    docker ps

    # Open VNC in your web browser
    xdg-open http://localhost:8080

### Deploy to Railway.com

This project is fully configured for Railway deployment:

1. **Connect your GitHub repository** to Railway
2. **Deploy**: Railway will automatically detect the Dockerfile and deploy your application
3. **Access**: Use the Railway-provided URL to access your Wine application via web browser
4. **VNC Password**: Use `$$Hello1$$` as the VNC password

#### Railway Configuration

- ✅ **Dynamic Port Handling**: Automatically adapts to Railway's assigned port
- ✅ **Docker Build**: Uses Dockerfile for containerized deployment  
- ✅ **Process Management**: Supervisor manages all services (X11, VNC, noVNC, Fluxbox, Wine)
- ✅ **Resource Optimization**: Includes .dockerignore for faster builds

#### Environment Variables

The application automatically handles Railway's `PORT` environment variable. No additional configuration needed.

In your web browser, enter `$$Hello1$$` as the password, and you will see a modern XFCE desktop with:

- 🎮 **Roblox Studio** - Ready for game development (automatically installed)
- 🌐 **Firefox Browser** - Modern web browsing experience  
- ⌨️ **Virtual Keyboard** - On-screen keyboard for mobile/touch devices
- 🖥️ **XFCE Desktop** - Clean, modern interface
- 🍷 **Wine 64-bit** - Run Windows applications seamlessly

## 🎮 Using Roblox Studio

Roblox Studio is automatically installed and configured:

1. **Access the desktop** via noVNC in your web browser
2. **Find Roblox Studio** on the desktop or in the applications menu
3. **Start developing** your games immediately!

The container includes all necessary Windows components (Visual C++ Runtime, .NET Framework) for Roblox Studio to run smoothly.

## ⌨️ Using the Virtual Keyboard

Perfect for mobile devices, tablets, and touch screens:

1. **Desktop shortcut** - Click the "Virtual Keyboard" icon on the desktop
2. **Auto-show** - Keyboard appears automatically when you click text fields
3. **Touch-friendly** - Optimized for touch input and mobile devices
4. **Customizable** - Resize and position the keyboard as needed
5. **Smart hide** - Automatically hides when not needed to save screen space

**Mobile tip**: The virtual keyboard makes Roblox Studio development possible on tablets and phones!

## 🛠️ Customization

This container provides a complete development environment. You can:

- **Install additional software** using `apt` (Linux) or through Wine (Windows apps)
- **Customize the XFCE desktop** environment to your preferences
- **Add your own applications** by modifying the Docker image
- **Use Firefox** to browse documentation, tutorials, or the Roblox Developer Hub

## ✨ Features

- ✅ **64-bit Wine** for modern application compatibility
- ✅ **Modern XFCE desktop** instead of basic window manager
- ✅ **Pre-installed Roblox Studio** ready for game development
- ✅ **Firefox browser** for web access
- ✅ **Virtual keyboard (Onboard)** for mobile/touch device support
- ✅ **Automatic Windows component installation** (fonts, runtimes)
- ✅ **Railway.com deployment ready**
