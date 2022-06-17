#!/bin/bash

export corGreen="\033[1;32m" #Instalação VERDE
export corBlue="\033[1;34m" #Atualização AZUL
export corRed="\033[1;31m" #Remoção VERMELHO
export corGrey="\033[40;1;37m" #CINZA
export corYellow="\033[1;33m" # configurando AMARELO

senha="juangomes1519"

echo ""
echo -e  " --- removendo travas do apt  --- \033[1;31m"
echo ${senha} | ( sudo -S sudo rm /var/lib/apt/lists/* -vf && sudo -S apt clean -y && sudo -S apt autoclean -y && sudo -S dpkg --configure -a && sudo -S rm /var/lib/apt/lists/lock && sudo -S rm /var/cache/apt/archives/lock && sudo -S rm /var/lib/dpkg/lock* sudo -S rm /var/lib/dpkg/lock-frontend && sudo -S rm /var/cache/debconf/config.dat && sudo -S dpkg --configure -a && sudo -S apt update -y )
echo ""

echo ""
echo -e  " --- remocao completa do libreoffice --- \033[1;31m"
echo ${senha} | ( sudo -S apt-get remove -y --purge libreoffice-common )
echo ""

echo ""
echo -e  " --- instalando o node LTS ---"
echo ${senha} | ( curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo -S apt-get update && sudo -S apt-get install -y nodejs )
echo ""

echo ""
echo -e  " --- instalando o yarn LTS ---"
echo ${senha} | ( curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && sudo apt update && sudo apt install -y yarn )
echo ""

echo ""
echo -e  " ---  instalando os programas do flathub (spotify, vscode, Figma, onlyoffice, github, telegram, discordapp, syncthingtk, kdenlive  ) ---"
echo ${senha} | (  flatpak install flathub -y com.spotify.Client com.visualstudio.code io.github.Figma_Linux.figma_linux  org.onlyoffice.desktopeditors io.github.shiftey.Desktop org.telegram.desktop com.discordapp.Discord me.kozec.syncthingtk org.kde.kdenlive flathub com.brave.Browser )
echo ""

echo ""
echo -e  " --- instalando o vscode via ppa oficial ---"
echo ${senha} | ( sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg && sudo apt-get update && sudo apt-get install code )
echo ""

echo ""
echo -e  " --- instalando o unzip ---"
echo ${senha} | ( sudo -S apt install -y unzip )
echo ""

echo ""
echo -e  " --- instala o docker e configura o portainer ---"
echo ${senha} | ( sudo  apt-get install  -y curl apt-transport-https ca-certificates software-properties-common && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && sudo apt update && sudo apt install -y docker-ce && sudo docker volume create portainer_data && sudo docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer -H unix:///var/run/docker.sock )
echo ""

echo ""
echo -e  " --- instalando o zsh/ohmyzsh/zinit ---"
echo ${senha} | (  sudo -S apt install -y zsh && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)" )
echo ""

echo ""
echo -e  " --- instalando as extencoes para o zsh ---"
echo ${senha} | ( zsh && zinit light zdharma/fast-syntax-highlighting && zinit light zsh-users/zsh-autosuggestions && zinit light zsh-users/zsh-completions )
echo ""

echo ""
echo -e  " --- instalando o tema omni ---"
echo ${senha} | ( cd && sudo -S apt-get install -y dconf-cli && $ git clone https://github.com/getomni/gnome-terminal.git && cd gnome-terminal && ./install.sh )
echo ""

echo ""
echo -e  " --- configurando o zsh por padrao para os users ---"
echo ${senha} | ( cd /etc && sudo -S sed -i 's/bash/zsh/g' passwd && cd  )
echo ""

echo ""
echo -e  " --- ubunto extras ---"
echo ${senha} | ( sudo -S apt --no-install-recommends install ubuntu-restricted-extras -y )
echo ""

echo ""
echo -e  " --- instalacao da fonte JetBrains Mono ---"
echo ${senha} | ( sudo -S chmod -R 777 /usr/share/fonts && cd /usr/share/fonts && wget https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip && unzip JetBrainsMono-2.242.zip && sudo rm -R JetBrainsMono-2.242.zip && cd )
echo ""

echo ""
echo -e  " --- preparando para trocar os temas  ---"
echo ${senha} | ( sudo -S apt install -y gnome-tweaks && sudo -S apt install -y gnome-shell-extensions )
echo ""

echo ""
echo -e  " --- copiando os themas para as pastas  ---"
echo ${senha} | ( cd && mkdir .themes && mkdir .icons && cd /home/dev/Documents/posinstall && cp -r gtk-master /home/dev/.themes && cp -r dracula-icons-main /home/dev/.icons  )
echo ""

echo ""
echo -e  " --- copiando as extençoes para a pasta certa---"
echo ${senha} | (  cd /home/dev/.local/share/gnome-shell && mkdir extensions && cd /home/dev/Documents/posinstall && cp -r bluetooth-quick-connect@bjarosze.gmail.com /home/dev/.local/share/gnome-shell/extensions && cp -r sound-output-device-chooser@kgshank.net  /home/dev/.local/share/gnome-shell/extensions && cp -r simplenetspeed@biji.extension /home/dev/.local/share/gnome-shell/extensions  && cd )
echo ""

echo ""
echo -e  " --- trocando o wallpaper ---"
echo ${senha} | ( gsettings set org.gnome.desktop.background picture-uri-dark 'file:///home/dev/Documents/posinstall/123.png' )
echo ""

echo ""
echo -e  " --- reiniciando o shell ---"
echo ${senha} | ( killall -HUP gnome-shell )
echo ""

echo ""
echo -e  " --- ativando os temas  ---"
echo ${senha} | ( gsettings set org.gnome.desktop.interface gtk-theme "gtk-master" && gsettings set org.gnome.desktop.interface icon-theme "dracula-icons-main" && gsettings set org.gnome.shell.extensions.user-theme name "gtk-master")
echo ""

echo ""
echo -e  " --- atualizacao final do sistema --- \033[1;34m"
echo ${senha} | (sudo -S apt-get update && sudo -S apt-get -y full-upgrade && sudo -S apt-get -y autoremove && sudo -S apt-get -y autoclean)
echo ""

