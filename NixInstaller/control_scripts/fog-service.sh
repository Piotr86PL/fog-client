#!/bin/bash

### BEGIN INIT INFO
# Provides:          fog-service.sh
# Required-Start:    $local_fs $syslog $remote_fs
# Required-Stop:     $local_fs $syslog $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start fog service
### END INIT INFO

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
DAEMON=mono-service
NAME=fog-service
DESC=fog-service

WORKINGDIR=/opt/fog-service/
LOCK=service.lock
FOGSERVICE=FOGService.exe
PID="`cat ${WORKINGDIR}${LOCK}`"

case "$1" in
        start)
                if [ -z "${PID}" ]; then
                        echo "starting ${NAME}"
                        ${DAEMON} ${WORKINGDIR}${FOGSERVICE} -d:${WORKINGDIR} -o:${WORKINGDIR}${LOCK}
                        echo "${NAME} started"
                else
                        echo "${NAME} is running"
                fi
        ;;
        stop)
                if [ -n "${PID}" ]; then
                        ${DAEMON} kill ${PID}
                        echo "${NAME} stopped"
                else
                        echo "${NAME} is not running"
                fi
        ;;
esac

exit 0