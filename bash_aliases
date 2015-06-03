
# aliases to keep your life easier...
alias h='history'
alias j="jobs -l"
alias pu="pushd"
alias po="popd"
alias texclean='rm -f *.toc *.aux *.lo[gft] *.d *.bbl *.blg *.cp *.fn *.tp *.vr *.pg *.ky */*.aux'
alias iso2utf='iconv -f iso-8859-1 -t utf-8'
alias utf2iso='iconv -t iso-8859-1 -f utf-8'
alias clean='echo -n "Really clean this directory (y/N)? ";
	read yorn;
	if test "$yorn" = "y"; then
	   rm -f \#* *~ .*~ *.bak .*.bak  *.tmp .*.tmp core a.out;
	   echo "Cleaned.";
	else
	   echo "Not cleaned.";
	fi'
# and to keep your life happier!
alias open='xdg-open'
alias e='vim -p'
alias em='vim -p `(git ls-files -m -o --exclude-standard; git diff --cached --name-only) | sort | uniq | grep -v log.txt`'
alias eb='vim -p `git show --name-only --oneline | egrep -v "^[a-z0-9]+ "`'
alias ec='vim -p $(git diff --name-only --diff-filter=U)'
alias urlencode='python -c "import sys, urllib; print urllib.quote(sys.argv[1])"'
alias urldecode='python -c "import sys, urllib; print urllib.unquote_plus(sys.argv[1])"'
alias jsonfmt='python -mjson.tool'

alias docker-ip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# vim:set ft=sh:
