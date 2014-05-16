#!/bin/bash
# Helps to control multiple instances of Tomcat, complementing the create-tomcat-bases.sh script

set -e
error(){ echo $*; exit 1; }
usage(){
	error "Usage: `basename $0` [-c CATALINA_HOME] CATALINA_BASE start|stop"
}

# defaults
catalina_home=~/opt/apache-tomcat-7.0.27
catalina_bases_prefix=~/opt/base-

[ "x$2" == "x" ] && usage
if [ "$1" = "-c" ]; then
	catalina_home="$2"; shift; shift;
fi
[ "x$2" == "x" ] && usage

catalina_base=$1
if [ ! -d "$catalina_base" ]; then
	# if catalina_base is not found, try appending the preffix
       if [ -d "${catalina_bases_prefix}-$catalina_base" ]; then
	      catalina_base="${catalina_bases_prefix}-$catalina_base"
	       echo "Found catalina base: $catalina_base"
      fi
fi
command=$2

export CATALINA_HOME=$catalina_home
[ -d $CATALINA_HOME ] || error "$CATALINA_HOME not found!"
export CATALINA_BASE=$catalina_base
[ -d $CATALINA_BASE ] || error "$CATALINA_BASE not found!"

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
