
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
alias e="$EDITOR"
alias urlencode='python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))"'
alias urldecode='python3 -c "import sys, urllib.parse; print(urllib.parse.unquote_plus(sys.argv[1]))"'
alias jsonfmt='python -mjson.tool'

alias docker-ip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
alias docker-ip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
alias dco="docker compose"
alias dcm="docker compose"
alias dcu="docker compose up -d"
alias dcd="docker compose down --remove-orphans"
alias dcdv="docker compose down --remove-orphans --volumes"
alias ldo="lazydocker"

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

if command -v eza &> /dev/null; then
    alias ls='eza'
fi

alias zbr='zig build run'

# vim:set ft=sh:
