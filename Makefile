
all:
	ln -sfn $(CURDIR) $(HOME)/.config/nvim
	nvim -c PlugInstall -c quitall
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	rustup install stable
	rustup component add clippy
	nvim -c PlugStatus -c "write ./status" -c quitall
	cat ./status
