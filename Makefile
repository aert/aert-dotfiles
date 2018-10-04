
update:
	# Vim
	# ===
	cp ~/.vimrc user-config/
	# Other
	# =====
	#cp ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings user-config/
	cp ~/.zshrc user-config/
	cp ~/.zsh_plugins.txt user-config/
	cp ~/.ackrc user-config/
	cp /etc/fstab system-config/etc/
	cp -R ~/.byobu user-config/
	cp -R ~/.config/tmuxinator user-config/.config/

	cp ~/.ctags user-config/
	cp -R ~/.git_template user-config/

update-danger:
	cp ~/.gitconfig user-config/
