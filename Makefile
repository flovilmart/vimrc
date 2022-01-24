ifndef TMPDIR
override TMPDIR = `mktemp -d`
endif
all:
	brew bundle
	ln -sfn $(CURDIR) $(HOME)/.config/nvim
	nvim -u ~/.config/nvim/vimrcs/plugged.vim -c PlugInstall -c quitall
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	rustup install stable
	rustup component add clippy
	nvim -c PlugStatus -c "write $(TMPDIR)/PlugStatus.out" -c quitall
	cat $(TMPDIR)/PlugStatus.out
