ifndef TMPDIR
override TMPDIR = `mktemp -d`
endif
all:
	brew bundle
	ln -sfn $(CURDIR) $(HOME)/.config/nvim
	nvim -u ~/.config/nvim/vimrcs/plugged.vim -c PlugInstall -c quitall
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	~/.cargo/bin/rustup install stable
	~/.cargo/bin/rustup component add clippy
	# GO111MODULE=on go get golang.org/x/tools/gopls@latest
	nvim -c PlugStatus -c "write $(TMPDIR)/PlugStatus.out" -c quitall
	cat $(TMPDIR)/PlugStatus.out
	# ln -sfn /usr/local/bin/nvim /usr/local/bin/vi

java:
	brew install jdtls
