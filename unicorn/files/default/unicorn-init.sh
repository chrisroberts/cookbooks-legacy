#!/bin/sh
set -e

# Stolen from: <http://github.com/defunkt/unicorn/blob/master/examples/init.sh>

# Example init script, this can be used with nginx, too,
# since nginx and unicorn accept the same signals
 
# Feel free to change any of the following variables for your app:
APP_ROOT=/var/www/current
PID=/var/run/unicorn.pid
CMD="/usr/local/bin/unicorn_rails -D -c /etc/unicorn/app.rb"
#INIT_CONF=$APP_ROOT/config/init.conf
 
#test -f "$INIT_CONF" && . $INIT_CONF
 
old_pid="$PID.oldbin"
 
cd $APP_ROOT || exit 1
 
sig () {
	test -s "$PID" && kill -$1 `cat $PID`
}
 
oldsig () {
	test -s $old_pid && kill -$1 `cat $old_pid`
}
 
case $1 in
start)
	sig 0 && echo >&2 "Already running" && exit 0
	$CMD
	;;
stop)
	sig QUIT && exit 0
	echo >&2 "Not running"
	;;
force-stop)
	sig TERM && exit 0
	echo >&2 "Not running"
	;;
restart|reload)
	sig HUP && echo reloaded OK && exit 0
	echo >&2 "Couldn't reload, starting '$CMD' instead"
	$CMD
	;;
upgrade)
	sig USR2 && sleep 2 && sig 0 && oldsig QUIT && exit 0
	echo >&2 "Couldn't upgrade, starting '$CMD' instead"
	$CMD
	;;
*)
	echo >&2 "Usage: $0 <start|stop|restart|upgrade|force-stop>"
	exit 1
	;;
esac