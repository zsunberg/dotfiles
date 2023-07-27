# makefile for restoring settings

.PHONY: backup vim vimrc vundle bashrc git

# git:
	# git commit -a; ( git pull origin master && git push origin master )

vim: vundle vimrc

vimrc:
	rm -f ~/.vimrc.old && mv -n ~/.vimrc ~/.vimrc.old
	ln -s dotfiles/.vimrc ~/.vimrc

vundle: vimrc ~/.vim/bundle/Vundle.vim/README.md
	vim +BundleInstall +qall

~/.vim/bundle/Vundle.vim/README.md:
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

bashrc:
	rm -f ~/.bashrc.old && mv -n ~/.bashrc ~/.bashrc.old
	ln -s dotfiles/.bashrc ~/.bashrc

# kde:
# 	-( mv -n ~/.kde ~/.kde.old && rm ~/.kde )
# 	ln -s dotfiles/.kde ~/.kde

BACKUP=mv -f $@ $@.old; cp $< $@

backup: fstab xorg.conf.home xorg.conf.homer xorg.conf.triple 

fstab: /etc/fstab
	$(BACKUP)

xorg.conf.home: /etc/X11/xorg.conf.home
	$(BACKUP)
	
xorg.conf.homer: /etc/X11/xorg.conf.homer
	$(BACKUP)

xorg.conf.triple: /etc/X11/xorg.conf.triple
	$(BACKUP)

# .PHONY: disable-lightdm
# 
# disable-lightdm:
# 	echo "manual" | sudo tee -a /etc/init/lightdm.override
