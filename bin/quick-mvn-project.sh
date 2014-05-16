#!/bin/bash

usage() {
	echo "Usage: `basename $0` [-g GROUP_ID|-a ARCHETYPE] PROJECT_NAME"; exit 1;
}

# set your default package here
package=eliasd
archetype=maven-archetype-quickstart
archetypeGroupId=org.apache.maven.archetypes

# gather options from cmdline
while getopts g:a: flag; do
	case "$flag" in
		g) package="$OPTARG" ;;
		a)
			archetype="$OPTARG"
			if [ "$OPTARG" == "webapp" ]; then
			       	archetype="webapp-javaee6"
				archetypeGroupId="org.codehaus.mojo.archetypes"
			fi
			;;
		?) usage ;;
	esac
done
shift $((OPTIND - 1))
[ "x$1" == "x" ] && usage;
proj_name="$1"

mvn archetype:generate -B -DarchetypeGroupId=$archetypeGroupId -DarchetypeArtifactId="$archetype" \
	-DgroupId=$package -DartifactId="$proj_name" -Dpackage=$package
