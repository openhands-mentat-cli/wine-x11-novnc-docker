## wine-x11-novnc-docker

![Docker Image Size (tag)](https://img.shields.io/docker/image-size/solarkennedy/wine-x11-novnc-docker/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/solarkennedy/wine-x11-novnc-docker)

Not a very good name, is it?

Ever wanted to containerize your wine applications and access them via
a web browser? No? Neither did I!

This container runs:

* Xvfb - X11 in a virtual framebuffer
* x11vnc - A VNC server that scrapes the above X11 server
* [noNVC](https://kanaka.github.io/noVNC/) - A HTML5 canvas vnc viewer
* Fluxbox - a small window manager
* Explorer.exe - to demo that it works

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

In your web browser, type the container ID as password, and then you should see the default application, explorer.exe:

![Explorer Screenshot](https://raw.githubusercontent.com/solarkennedy/wine-x11-novnc-docker/master/screenshot.png)

## Modifying

This is a base image. You should fork or use this base image to run your own wine programs?

## Issues

* Wine could be optimized a bit
* Fluxbox could be skinned or reduced
