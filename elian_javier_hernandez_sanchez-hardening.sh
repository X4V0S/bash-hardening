#!/usr/bin/sh


# Clamav: clamav.net
# EPEL: docs.fedoraproject.org/en-US/epel/


NC='\e[0m' 			# No Color
IRed='\e[0;91m'		# Red
IGreen='\e[0;92m'	# Green
IYellow='\e[0;93m'	# Yellow
IWhite='\e[0;97m'	# White


# Sistema Operativo: Ubuntu #
if grep debian /etc/os-release ; then
	if apt list --installed | grep clamav ; then
		echo "${IYellow} Desinstalando clamav ${NC}"
		yes '' | sudo apt-get autoremove clamav clamav-daemon
		echo "${IRed} Clamav desinstalado. ${NC}"
	fi
	echo "${IYellow} Instalando clamav ${NC}"
	yes '' | sudo apt-get install clamav clamav-daemon
	echo "${IGreen} Clamav instalado. ${NC}"

	echo "${IYellow} Actualizando paquetes ${NC}"
	yes '' | sudo apt-get update && yes '' | sudo apt-get upgrade
	echo "${IGreen} Paquetes actualizados. ${NC}"

	echo "${IWhite} Tarea completada. ${NC}"

# Sistema Operativo: CentOS #
else
	if ! yum list installed | grep epel-release ; then
		echo -e "${IYellow} Instalando epel-release ${NC}"
		sudo yum -y install epel-release && sudo yum clean all
		echo "${IGreen} epel-release instalado. ${NC}"
	fi

	if yum list installed | grep clamav ; then
		echo -e "${IYellow} Desinstalando clamav ${NC}"
		sudo yum -y remove clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd
		echo -e "${IRed} Clamav desinstalado. ${NC}"
	fi
	echo -e "${IYellow} Instalando clamav ${NC}"
	sudo yum -y install clamav-server clamav-data clamav-update clamav-filesystem clamav clamav-scanner-systemd clamav-devel clamav-lib clamav-server-systemd
	echo -e "${IGreen} Clamav instalado. ${NC}"

	echo -e "${IYellow} Actualizando paquetes ${NC}"
	sudo yum -y update
	echo -e "${IGreen} Paquetes actualizados. ${NC}"

	echo -e "${IWhite} Tarea completada. ${NC}"
fi
