__formatted_git_ps1_branch() {
	branch=$(__git_ps1 "[%s]")
	if [ ${#branch} -ge 15 ]; then
		printf "%.15s..." $branch
	else
		echo $branch
	fi

	return 0
}
