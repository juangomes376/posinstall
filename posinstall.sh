#!/bin/bash

# desintala por completo o libreoffice
sudo apt-get remove --purge libreoffice-common 

# instala o  node 
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get update
sudo apt-get install -y nodejs

# instala o  yarn
curl -sS <https://dl.yarnpkg.com/debian/pubkey.gpg> | sudo apt-key add -
echo "deb <https://dl.yarnpkg.com/debian/> stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install yarn

# instalando todos os programas via flatpak
flatpak install flathub com.spotify.Client
flatpak install flathub com.visualstudio.code
flatpak install flathub io.github.Figma_Linux.figma_linux
flatpak install flathub net.cozic.joplin_desktop
flatpak install flathub org.onlyoffice.desktopeditors
flatpak install flathub io.github.shiftey.Desktop
flatpak install flathub org.telegram.desktop
flatpak install flathub com.discordapp.Discord
flatpak install flathub org.kde.kdenlive
flatpak install flathub me.kozec.syncthingtk

# instalando unzip
sudo apt install unzip

# baixando e instalando o vivalde 
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | gpg --dearmor | sudo dd of=/usr/share/keyrings/vivaldi-browser.gpg
echo "deb [signed-by=/usr/share/keyrings/vivaldi-browser.gpg arch=$(dpkg --print-architecture)] https://repo.vivaldi.com/archive/deb/ stable main" | sudo dd of=/etc/apt/sources.list.d/vivaldi-archive.list
sudo apt update  
sudo apt install vivaldi-stable

# instalando e configurando docker + portainer
sudo apt-get install \\
    apt-transport-https \\
    ca-certificates \\
    curl \\
    gnupg-agent \\
    software-properties-common
curl -fsSL <https://download.docker.com/linux/debian/gpg> | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88 
curl -fsSL [<https://get.docker.com>](<https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqazNTXzgzbkZXSnV4S2EwNlI3TWQ5eDQxeE9RUXxBQ3Jtc0ttWXVoQ2g1UUk4N3ozZnBnNlpiUk9GaTdaYlhjb0JwdGRwb2N1QWpraXRyTDV3WEhOc1JJTEpYSWlDMVpDY19YWE9QV3VvYTVtRV9aZ09nSG4ybm9GMEI0U3pUZVk5NzhqeDYzUUFudnBRaEotZGg2bw&q=https%3A%2F%2Fget.docker.com>) -o get-docker.sh
sudo sh get-docker.sh
sudo docker volume create portainer_data
sudo docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer -H unix:///var/run/docker.sock

# instalando o ohmyzsh/zinit
sudo apt-get install dconf-cli
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://git.io/zinit-install)"
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

# configurando o zsh por padrao para o user (dev) e (root)
cd /etc
sudo sed -i 's/bash/zsh/g' passwd
cd 

# instalando o tema omni no zsh
git clone https://github.com/getomni/gnome-terminal.git
cd gnome-terminal
./install.sh

# fonte JetBrains Mono
cd /
cd usr/share/fonts
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.242.zip
unzip JetBrainsMono-2.242.zip
sudo rm -R JetBrainsMono-2.242.zip
cd 

# instalando as extençoes do gnome 
sudo apt install gnome-shell-extensions

# kdeconect
gnome-extensions install --force gsconnect@andyholmes.github.io.zip

# Bluetooth Quick Connect
git clone https://github.com/bjarosze/gnome-bluetooth-quick-connect
cd gnome-bluetooth-quick-connect
make
rm -rf ~/.local/share/gnome-shell/extensions/bluetooth-quick-connect@bjarosze.gmail.com
mkdir -p ~/.local/share/gnome-shell/extensions/bluetooth-quick-connect@bjarosze.gmail.com
cp -r * ~/.local/share/gnome-shell/extensions/bluetooth-quick-connect@bjarosze.gmail.com

# net speed
$ git clone https://github.com/AlynxZhou/gnome-shell-extension-net-speed.git ~/.local/share/gnome-shell/extensions/netspeed@alynx.one

# Sound Input & Output Device Chooser
cd ~/.local/share/gnome-shell/extensions/
rm -rf *sound-output-device-chooser*
git clone https://github.com/kgshank/gse-sound-output-device-chooser.git
cp -r gse-sound-output-device-chooser/sound-output-device-chooser@kgshank.net .
rm -rf "gse-sound-output-device-chooser"

# habilitanto todas as extençoes 
gnome-extensions enable sound-output-device-chooser@kgshank.net
gnome-extensions enable bluetooth-quick-connect@bjarosze.gmail.com
gnome-extensions enable gsconnect@andyholmes.github.io
gnome-extensions enable netspeed@alynx.one


# thema dracula no sistema 

mkdir .themes
mkdir .icons

# GTK
cd .themes
wget https://github.com/dracula/gtk/archive/master.zip
unzip master.zip
sudo rm -R master.zip
gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"
cd 

# icon theme
cd .icons
wget https://github.com/dracula/gtk/files/5214870/Dracula.zip
unzip Dracula.zip
sudo rm -R Dracula.zip
gsettings set org.gnome.desktop.interface icon-theme "Dracula"
cd 

# atualizacao final do sistema
sudo apt-get update
sudo apt-get full-upgrade
sudo apt-get autoremove
sudo apt-get autoclean

# reinicia  o sistema
sudo reboot
