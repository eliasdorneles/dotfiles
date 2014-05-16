#!/bin/bash
# Script to help control multiple instances of Tomcat
# Author: elias.dorneles gmail com

set -e
error(){ echo $*; exit 1; }
usage(){
	error "Usage: `basename $0` [-c CATALINA_HOME] start|stop"
}

# defaults
catalina_home=~/opt/apache-tomcat-7.0.27
catalina_bases_prefix=~/opt/base-

[ "x$1" == "x" ] && usage
if [ "$1" = "-c" ]; then
	catalina_home="$2"; shift; shift;
fi
[ "x$1" == "x" ] && usage
command=$1

# TODO: add support for -b CATALINA_BASE
catalina_base=.

export CATALINA_HOME=$catalina_home
[ -d $CATALINA_HOME ] || error "$CATALINA_HOME not found!"
[ -d "$CATALINA_HOME/bin" ] || error "$CATALINA_HOME/bin not found! Is $CATALINA_HOME a valid CATALINA_HOME?"
export CATALINA_BASE=$catalina_base
[ -d "$CATALINA_BASE" ] || error "$CATALINA_BASE not found!"
[ -d "$CATALINA_BASE/conf" ] || error "$CATALINA_BASE/conf not found! Is $CATALINA_BASE a valid CATALINA_BASE?"

if [ "$command" == "start" ]; then
	cmd=$CATALINA_HOME/bin/startup.sh
elif [ "$command" == "stop" ]; then
	cmd=$CATALINA_HOME/bin/shutdown.sh
else
	cmd="$CATALINA_HOME/bin/catalina.sh $command"
fi

echo "running: $cmd"
echo
$cmd

exit $?
