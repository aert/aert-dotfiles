
update:
	# Vim
	# ===
	cp ~/.vimrc user-config/
	cp -R ~/.i3 user-config/
	cp ~/.i3status.conf user-config/
	cp -R ~/.config/ranger/rifle.conf user-config/config/ranger/
	# Other
	# =====
	#cp ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings user-config/
	cp ~/.zshrc user-config/
	cp ~/.zsh_plugins.txt user-config/
	cp ~/.ackrc user-config/
	cp /etc/fstab system-config/etc/
	#-- tmux
	rm -rf user-config/.byobu user-config/.config/tmuxinator
	cp -R ~/.byobu user-config/
	rm -f user-config/.byobu/.ssh-agent
	cp -R ~/.config/tmuxinator user-config/.config/
	#-- git/ctags
	rm -rf user-config/.git_template
	cp ~/.ctags user-config/
	cp -R ~/.git_template user-config/
	#-- my_scripts
	rm -rf ./my_scripts
	cp -R ~/bin/my_scripts/ ./

update-danger:
	cp ~/.gitconfig user-config/
