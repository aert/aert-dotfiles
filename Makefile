
update:
	# Vim
	# ===
	cp ~/.config/nvim/init.vim user-config/config/nvim/
	cp -R ~/.vim/UltiSnips user-config/.vim
	# i3
	cp -R ~/.config/i3 user-config/config
	cp ~/.i3status.conf user-config/
	cp -R ~/.config/ranger/rifle.conf user-config/config/ranger/
	cp ~/.config/compton.conf user-config/config/
	# Other
	# =====
	#cp ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings user-config/
	cp ~/.zshrc user-config/
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
	#-- my_scripts
	rm -rf ./my_scripts
	cp -R ~/bin/my_scripts/ ./

update-danger:
	cp ~/.gitconfig user-config/
