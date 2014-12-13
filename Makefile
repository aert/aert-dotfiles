
update:
	# Vim
	# ===
	cp ~/.vimrc user-config/
	# Vimperator
	# ==========
	mkdir -p user-config/.vimperator/
	cp ~/.vimperatorrc user-config/
	cp -R ~/.vimperator/colors/ user-config/.vimperator/
	# Other
	# =====
	#cp ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings user-config/
	cp ~/.zshrc user-config/
	cp /etc/fstab system-config/etc/

update-danger:
	cp ~/.gitconfig user-config/
