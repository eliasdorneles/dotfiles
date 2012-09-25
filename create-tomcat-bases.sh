#!/bin/bash
# Create multiple CATALINA_BASEs for a Tomcat installation, useful for quickly
# creating a sandbox to test new applications

error(){ echo "$*"; exit 1; }
usage(){
	error """Usage: `basename $0` [-c CATALINA_HOME] tomcat_base...

	If tomcat_base contains a port number 8x80, the script
	tries to update server.xml to use 8x preffix for the other ports"""
}

set -e
catalina_home=~/opt/apache-tomcat-7.0.27/
[ "x$1" == "x" ] && usage
if [ "$1" = "-c" ]; then
	catalina_home="$2"; shift; shift;
fi
[ "x$1" == "x" ] && usage

conf_dir=$catalina_home/conf
[ -d "$conf_dir" ] || error "Directory $conf_dir not found!"
[ -f "$conf_dir/server.xml" ] || error "File server.xml not found inside $conf_dir!"

for tomcat_base in "$@"
do
	[ -d "$tomcat_base" ] && error "Directory $tomcat_base already exists!"
	echo -n Creating $tomcat_base...
	# create and copy directories
	mkdir -p $tomcat_base/{logs,temp,webapps,work}
	cp -r "$conf_dir" "$tomcat_base"

	# if name contains a port number, update server.xml accordingly
	port=`echo $tomcat_base | grep -o 8.80`
	echo done
	if [ "x$port" != "x" ]; then
		echo Updating $tomcat_base/conf/server.xml
		port_prefix=${port:0:2}
		sed -i -E "
		s/8.(80|05|09)/${port_prefix}\1/g;
		# disable AJP connector
		#s/\r//g;
		#s/^(.*Connector port=\"8009\".*)$/<!--\n\1\n-->/;
		" $tomcat_base/conf/server.xml
	fi
done
