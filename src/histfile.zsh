
#--------------------------------------------------------------------#
# Histfile Helper Functions                                          #
#--------------------------------------------------------------------#

# Universal (Linux/BSD) md5 utility
_zsh_cwd_history_md5() {
	which md5 > /dev/null 2>&1 && md5 -q || (md5sum | cut -c-32)
}

# Echo the name of the history file to use for current working dir
# Uses the md5 hash of the absolute path
_zsh_cwd_history_histfile_for_cwd() {
	echo "$ZSH_CWD_HISTORY_DIR/.hist-$(echo "${PWD:A}" | _zsh_cwd_history_md5)"
}

# Switch to a new history file, writing to the old one
_zsh_cwd_history_switch_histfile() {
	local new_histfile=$1

	# Assert the directory exists
	mkdir -p "$ZSH_CWD_HISTORY_DIR"

	# Write old histfile
	fc -P

	# Read new histfile
	fc -p "$new_histfile"
}
