# sudo vi /etc/profile.d/gradle.sh

# Parametrias
export GRADLE_VERSION=gradle-7.0

export GRADLE_HOME=/opt/gradle/${GRADLE_VERSION}
export PATH=${GRADLE_HOME}/bin:${PATH}