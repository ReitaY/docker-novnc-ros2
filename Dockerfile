ARG ROS_DISTRO=humble

# buildx 使用時は $TARGETPLATFORM が自動注入される
FROM ros:${ROS_DISTRO}-ros-base

ARG TARGETPLATFORM TARGETARCH

RUN echo "buildx says: $TARGETPLATFORM / $TARGETARCH"

# Install git, supervisor, VNC, & X11 packages
RUN set -ex; \
    apt-get update; \
    apt-get install -y \
      bash \
      fluxbox \
      git \
      net-tools \
      novnc \
      supervisor \
      x11vnc \
      xterm \
      xvfb

# Setup demo environment variables
ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768 \
    RUN_XTERM=yes \
    RUN_FLUXBOX=yes

COPY . /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ros-${ROS_DISTRO}-desktop && \
    rm -rf /var/lib/apt/lists/*

CMD ["/app/entrypoint.sh"]
EXPOSE 8080
