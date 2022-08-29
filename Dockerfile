FROM linuxserver/code-server:arm64v8-4.5.0

RUN apt-get install software-properties-common

RUN add-apt-repository ppa:saiarcot895/chromium-dev

RUN apt-get update && \
  apt-get upgrade -y && \
  apt install -y ansible apt-transport-https build-essential ca-certificates chromium-browser ffmpeg gnupg-agent htop libffi-dev libssl-dev python3 python3-dev python3-pip software-properties-common systemd unzip vim wget

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash - && \
  apt-get install -y nodejs
RUN npm install -g yarn
RUN npm install -g pm2

RUN apt install -y zsh && \
  wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O install_zsh.sh && \
  chmod +x ./install_zsh.sh && \
  ZSH=~/.zsh && \
  ./install_zsh.sh --unattended && \
  chsh -s /bin/zsh

USER $DEFAULT_USER

RUN echo "fs.inotify.max_user_instances=524288" >> /etc/sysctl.conf
RUN echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf
RUN echo "fs.inotify.max_queued_events=524288" >> /etc/sysctl.conf

RUN apt-get clean

EXPOSE 8443
