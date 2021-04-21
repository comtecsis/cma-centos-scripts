#/bin/sh

# Dependencias
sudo yum -y install epel-release
sudo yum -y install ntfs-3g

# Parametrias
export MOUNT_WIN="YES" # YES | NO
export DISK_PARTITION=/dev/sda6
export USER_SO=synopsis
export GRADLE_VERSION=gradle-7.0
export UNRAR_VERSION=rarlinux-x64-5.5.0

# Montando particion primaria de windows
if [[ $MOUNT_WIN == "YES" ]];
then
echo "==========================="
echo "Montando particion primaria"
echo "==========================="
sudo mkdir -p /mnt/win
sudo mount -t ntfs-3g $DISK_PARTITION /mnt/win
fi

# Instalar docker
echo "====================="
echo "Instalacion de docker"
echo "====================="
sudo yum install -y yum-utils
sudo yum erase -y podman buildah
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo usermod -aG docker $USER_SO

echo "WARN: Si es la primera ejecución reinicia para reasignar grupo a usuario"

# Instalación de herramientas
echo "===================="
echo "Instalacion de tools"
echo "===================="
sudo yum install -y npm
sudo yum install -y maven 

if [[ "$(sudo find /tmp -name $GRADLE_VERSION-bin.zip)" == "" ]] ;
then
    wget https://services.gradle.org/distributions/$GRADLE_VERSION-bin.zip -P /tmp
    sudo unzip -d /opt/gradle /tmp/$GRADLE_VERSION-bin.zip
else
    echo "WARN: $GRADLE_VERSION ya esta descargado."
fi
sudo cp gradle.sh /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh

echo "=============="
echo "Install Unrar"
echo "=============="
if [[ "$(sudo find /tmp -name $UNRAR_VERSION.tar.gz)" == "" ]] ;
then
    wget https://www.rarlab.com/rar/$UNRAR_VERSION.tar.gz -O /tmp/$UNRAR_VERSION.tar.gz
    sudo mkdir -p /opt/unrar
    sudo tar -xf /tmp/$UNRAR_VERSION.tar.gz -C /opt
    sudo update-alternatives --install /usr/bin/rar rar /opt/rar/rar 0
    sudo update-alternatives --install /usr/bin/unrar unrar /opt/rar/unrar 0
else
    echo "WARN: $UNRAR_VERSION ya esta descargado."
fi

echo "¡Listo!"

echo "====="
echo "Otros"
echo "====="
echo "INFO: Descargar Android Studio"
echo "INFO: Configurar NDK y CMake"
echo "INFO: Descargar Spring Tool Suite"
echo "INFO: Configurar lombook"
echo "INFO: Descargar Tomcat"
echo "INFO: Descargar Wildfly"
echo "INFO: Descargar Intelij IDEA"