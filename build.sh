#! /bin/sh

[ ! "${MYSQL_PATH}" ] && MYSQL_PATH="/usr/local/mysql"

OS_TARGET=`uname -s`

case "$OS_TARGET" in
        linux* | Linux*)
	HOST_OS=Linux
		echo "#define USE_EPOLL_HANDLER" > ./src/configure.h
		echo "LINUX_BUILD = 1" > ./platform.mk
		echo "#define HAVE_VASPRINTF" >> ./src/configure.h
		echo "#define HAVE_ASPRINTF" >> ./src/configure.h
        ;;
        Darwin*)
        HOST_OS=Darwin
		echo "#define USE_KQUEUE_HANDLER" > ./src/configure.h
		echo "DARWIN_BUILD = 1" > ./platform.mk
		echo "#define HAVE_VASPRINTF" >> ./src/configure.h
		echo "#define HAVE_ASPRINTF" >> ./src/configure.h
        ;;
        SunOS)
	HOST_OS=Solaris
	        echo "#define USE_SELECT_HANDLER" > ./src/configure.h
		echo "SOLARIS_BUILD = 1" > ./platform.mk
		echo "LDFLAGS += -lnsl -lsocket" >> platform.mk
        ;;
        *)
	        echo "This platform is not supported." >/dev/stderr
		exit 1
        ;;
esac

echo "HAS_GPSEE=1" >> ./platform.mk

if [ -f "${MYSQL_PATH}/mysql.h" ]
then
    echo "HAS_MYSQL = yes" > ./modules/mysql.mk
	echo "#define _USE_MYSQL 1" >> ./src/configure.h
	cd ./modules/deps/mysac/
	make
	cd ../../../
else
	echo "HAS_MYSQL = 0" > ./modules/mysql.mk
	echo "#undef _USE_MYSQL" >> ./src/configure.h
fi

cd ./deps/udns-0.0.9/
make clean && ./configure && make
cd ../js/src/
./configure && make -j8
cd ../../../
make
cd ./modules/ && make
