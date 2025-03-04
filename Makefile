install:
	ln -sf ${PWD}/user-config/.ackrc ~/
	ln -sf ${PWD}/user-config/.ctags ~/
	ln -sf ${PWD}/user-config/.gemrc ~/
	ln -sf ${PWD}/user-config/.spacemacs.d/ ~/
	ln -sf ${PWD}/user-config/.tmux.conf ~/
	ln -sf ${PWD}/user-config/.zshrc ~/
	ln -sf ${PWD}/user-config/config/nvim/ ~/.config/

update:
	# Vim
	# ===
	#cp ~/.config/nvim/init.vim user-config/config/nvim/
	#cp -R ~/.vim/UltiSnips user-config/.vim
	# i3
	#cp -R ~/.config/i3 user-config/config
	#cp ~/.i3status.conf user-config/
	# cp -R ~/.config/ranger/rifle.conf user-config/config/ranger/
	#cp ~/.config/compton.conf user-config/config/
	# Other
	# =====
	#cp ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings user-config/
	cp ~/.zshrc user-config/
	cp ~/.ackrc user-config/
	# cp /etc/fstab system-config/etc/
	#-- tmux
	# rm -rf user-config/.byobu user-config/.config/tmuxinator
	# cp -R ~/.byobu user-config/
	# rm -f user-config/.byobu/.ssh-agent
	# cp -R ~/.config/tmuxinator user-config/.config/
	#-- git/ctags
	#rm -rf user-config/.git_template
	cp ~/.ctags user-config/
	#-- dunst
	#cp ~/.config/dunst/dunstrc user-config/config/dunst
	#cp -R ~/.config/zathura/ user-config/config/

update-danger:
	cp ~/.gitconfig user-config/

config_codium:
	ln -s ~/Code/aert/dotfiles/user-config/config/VSCodium/snippets ~/.config/VSCodium/User/
	ln -s ~/Code/aert/dotfiles/user-config/config/VSCodium/settings.json ~/.config/VSCodium/User/
	ln -s ~/Code/aert/dotfiles/user-config/config/VSCodium/keybindings.json ~/.config/VSCodium/User/
	xargs -n1 codium --install-extension < ~/Code/aert/dotfiles/user-config/config/VSCodium/__extensions.txt
