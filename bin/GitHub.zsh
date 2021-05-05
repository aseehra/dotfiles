action=''
remote_name=origin

while [ $# != 0 ] ; do
	case $1 in
		-r)
			[[ $# < 2 ]] && echo "Error: no remote name" && return 1
			remote_name="$2"
			shift
			;;
		*)
			if [[ -n "$action" ]] ; then
				echo "Error: only one action is allowed"
				return 1
			fi
			action="$1"
			;;
	esac
	shift
done

if ! git rev-parse 1>/dev/null 2>&1 ; then
	echo "Error: ths isn't a git directory"
	return 1
fi

git_url="$(git config --get remote.${remote_name}.url)"
git_url=${git_url%.git}

git_protocol="$(echo "$git_url" | awk -v FS="(@|:)" '{print $1}')"
if [[ "$git_protocol" == 'http' ]] || [[ "$git_protocol" == 'https' ]] ; then
	git_domain = "$(echo "git_url" | awk -F'/' '{print $3}')"
	git_url="$git_url"
elif [[ "$git_protocol" == 'git' ]] ; then
	git_url="${git_url#*@}"
	git_domain="$(echo "$git_url" | awk -F':' '{print $1}')"
	git_url="https://${git_url/://}"
elif [[ "$git_protocol" == 'github' ]] || [[ "$git_protocol" == 'gitlab' ]] ; then
	git_domain="${git_protocol}.com"
	git_url="https://${git_domain}/${git_url#*:}"
else
	echo "Error: $remote_name is invalid"
	return 1
fi

url="${git_url}"
git_branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)" || git_branch=''

case "$action" in
	'') action='home' ;;
	'-') action='current' ;;
	b) action='branches' ;;
	i) action='issues' ;;
	r) action='releases' ;;
	p) action='prs' ;;
	s) action='settings' ;;
	t) action='tags' ;;
	w) action='wiki' ;;
esac

case "$action" in
	'home') url="$url" ;;
	'branches') url="$url/branches" ;;
	'issues') url="$url/issues" ;;
	'prs') url="$url/pulls" ;;
	'releases') url="$url/releases" ;;
	'tags') url="$url/tags" ;;
	'repo-settings') url="$url/settings/repository" ;;
	'current')
		if [[ -z "$git_branch" ]] ; then
			echo "Error: no branch"
			return 1
		fi
		url="$url/tree/${git_branch}"
		;;
	'wiki')
		if [[ "$git_domin" == 'gitlab.com' ]] ; then
			url="$url/wikis"
		else
			url="$url/wiki"
		fi
		;;
	'settings')
		if [[ "$git_domain" == 'gitlab.com' ]] ; then
			url="$url/edit"
		else
			url="$url/settings"
		fi
		;;
	*)
		echo "Error: unknown action $action"
		return 1
esac
echo "Opening $url"
if [[ -f "/usr/bin/open" ]] ; then
	open "$url"
else
	gio open "$url"
fi
