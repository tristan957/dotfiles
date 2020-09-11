git_prompt_branch() {
	branch=$(__git_ps1 "[%s]")
	if [ ${#branch} -ge 20 ]; then
		printf "%.20s..." $branch
	else
		echo $branch
	fi

	return 0
}
